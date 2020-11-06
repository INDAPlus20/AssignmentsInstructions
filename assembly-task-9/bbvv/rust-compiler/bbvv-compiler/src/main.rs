/***
 * Compiler for Bacon Borde Vara Vegetarisk
 * - main application (file and error handling)
 * 
 * Run application by running the executable with the path
 * to a valid .bbvv file as the first argument. The bbvv-emulator
 * executable file ./output.bbvvexe should appear in the current drectory.
 * 
 * Author: Viola Söderlund <violaso@kth.se>
 * 
 * Created: 2020-11-06
 */

mod compiler;

use std::fs;
use std::io::prelude::*;
use std::io::{ ErrorKind };
use std::collections::{ HashMap };

/* System error codes are valid only for Windows. */

/// Error message tag for invalid argument.
const TAG_ARGUMENT_NOT_VALID: &str = "ArgumentNotValid";
const TAG_INSTRUCTION_PARSE_ERR: &str = "InstructionParseError";
const TAG_DEFINE_PARSE_ERR: &str = "DefineParseError";
const TAG_FAILED_TO_OUTPUT: &str = "OutputFailed";

/// Path to output file.
const OUT_FILE_PATH: &str = "../output.bbvvexe";

/// Print message with format "[ERROR] {<tag>}: {<err_msg>}".
fn print_error(tag: &str, err_msg: &str) {
    println!("[ERROR] {}: {}", tag, err_msg);
}

/// Print message with format "[ERROR] {<tag>}: {<err_msg>} (line {<line>})".
fn print_line_error(tag: &str, line: usize, err_msg: &str) {
    println!("[ERROR] {}: {} (line {})", tag, err_msg, line + 1);
}

/// False, if line is empty or only contains comment
fn line_has_code(line: &str) -> bool {
    !(line.is_empty() || &line.trim_start()[0..2] == "//")
}

/// Run compiler application.
/// #### Returns
/// An `Result` structure where:
/// - `Ok(())` means no errors
/// - `Err(<i32>)` means exit caused by error 
fn run_compiler() -> Result<(), ErrorKind> {
    println!("--- Bacon Borde Vara Vegetarisk Compiler ---\n");

    // get teminal/powershell/command promt arguments
    let args: Vec<String> = std::env::args().collect();

    // return on missing arguments
    if args.len() < 2 {
        print_error(TAG_ARGUMENT_NOT_VALID, "A path to a BBVV file must be provided!");
        Err(ErrorKind::InvalidData)
    }
    else {
        match fs::read_to_string(args[1].clone()) {
            // compile script on successful read
            Ok(_contents) => {
                println!("Compiling file: {:?}\n", args[1]);

                // get non-empty lines
                let lines: Vec<String> = _contents
                    .split("\r\n")
                    .map(|_line| _line.to_string())
                    .collect();

                // get section indexes
                let define_section_start_i = lines.iter().position(|_line| _line == ".define");
                let text_section_start_i = lines.iter().position(|_line| _line == ".text");

                //#region PRE-COMPILING

                /* Compiles the define section - associates each keyword with an instruction. */
                
                let mut definitions: HashMap<String, u8> = HashMap::new();

                // register definitions
                if define_section_start_i.is_some() {
                    let mut curr_i = define_section_start_i.unwrap() + 1;

                    // as long as current index is within the file's define section
                    while curr_i < lines.len() && Some(curr_i) != text_section_start_i {
                        // and line has code
                        if line_has_code(&lines[curr_i]) {
                            // parse define expression
                            match lines[curr_i].find(" ") {
                                Some(_split_i) => {
                                    let label = &lines[curr_i][.._split_i];
                                    let expr = &lines[curr_i][(_split_i + 1)..];

                                    // return on failed instruction parse
                                    match compiler::run(&expr[1..(expr.len() - 1)]) {
                                        Ok(_instr) => {
                                            definitions.insert(label.to_string(), _instr);
                                            ()
                                        },
                                        Err(_msg) => {
                                            print_line_error(TAG_INSTRUCTION_PARSE_ERR, curr_i, _msg.as_str());
                                            return Err(ErrorKind::Other);
                                        }
                                    }
                                },
                                None => {
                                    print_line_error(TAG_DEFINE_PARSE_ERR, curr_i, "Invalid define expression.");
                                    return Err(ErrorKind::Other);
                                }
                            }
                        }

                        curr_i += 1;
                    }

                    println!("Done pre-processing!");
                } else {
                    println!("No definition section found.");
                }

                //#endregion

                //region COMPILING

                let mut curr_i = match text_section_start_i {
                    Some(_i) => _i + 1,
                    None => 0
                };

                let mut executable: Vec<u8> = Vec::new();

                // compile expressions
                while curr_i < lines.len() {
                    if line_has_code(&lines[curr_i]) {
                        match definitions.get(lines[curr_i].split_whitespace().next().unwrap()) {
                            Some(_instr) => executable.push(*_instr),
                            None => {
                                match compiler::run(lines[curr_i].as_str()) {
                                    Ok(_instr) => executable.push( _instr),
                                    Err(_msg) => {
                                        print_line_error(TAG_INSTRUCTION_PARSE_ERR, curr_i, _msg.as_str());
                                        return Err(ErrorKind::Other);
                                    }
                                }
                            }
                        }
                    }

                    curr_i += 1;
                }

                println!("Done compiling!");

                //#endregion

                // write executable to output file
                match fs::OpenOptions::new().write(true).create(true).open(OUT_FILE_PATH) {
                    Ok(mut _file) => {
                        match _file.write_all(&executable) {
                            Ok(()) => {
                                println!("Done writing to output!\n\nExecutable code found at: \"{}\"\n--------------------------------------------", OUT_FILE_PATH);
                                Ok(())
                            },
                            Err(_err) => {
                                print_line_error(TAG_FAILED_TO_OUTPUT, curr_i, "Failed to open or create output file.");
                                Err(_err.kind())
                            }
                        }
                    },
                    Err(_err) => {
                        print_line_error(TAG_FAILED_TO_OUTPUT, curr_i, "Failed to open or create output file.");
                        Err(_err.kind())
                    }
                }
            },
            // return on io error
            Err(_err) => {
                print_error(TAG_ARGUMENT_NOT_VALID, match _err.kind() {
                    ErrorKind::InvalidData => "The provided path is not a path!",
                    ErrorKind::NotFound => "File not found!",
                    _ => "Failed to read file!"
                });
                Err(_err.kind())
            }
        }
    }
}

fn main() {
    // run and exit application
    std::process::exit(match run_compiler() {
        Ok(_) => 0,
        Err(_err) => {
            eprintln!("Program exited on error {:?}.", if _err == ErrorKind::Other {
                "CompilationFault".to_string()
            } else {
                format!("{:?}", _err)
            });
            1
        }
    });
}