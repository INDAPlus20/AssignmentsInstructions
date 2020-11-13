/***
 * Compiler for Bacon Borde Vara Vegetarisk
 * - compiler logic
 * 
 * Author: Viola Söderlund <violaso@kth.se>
 * 
 * Created: 2020-11-06
 */

/* System parameters. */
const INSTRUCTION_LENGTH: usize = 8;

/* Encoding parameters. */
const ADDR_LENGTH: usize = 5;

/* Operation codes. */
type OperationCode = [bool; 3];
const ADD_OP: OperationCode = [ false, false, false ];
const SUB_OP: OperationCode = [ false, false, true ];
const SET_OP: OperationCode = [ false, true, false ];
const J_OP: OperationCode = [ false, true, true ];
const JEQ_OP: OperationCode = [ true, false, false ];
const CAL_OP: OperationCode = [ true, false, true ];

/* Registry addresses. */
type Registry = [bool; 2];
const R0: Registry = [ false, false ];
const R1: Registry = [ false, true ];
const R2: Registry = [ true, false ];
const R3: Registry = [ true, true ];

/// Instruction types of the instruction set.
#[derive(PartialEq)]
enum InstructionType {
    /// Type for the addition, subtraction, set and jump on equal instructions.
    Arithmetic, 
    /// Type for the jump and system call instructions.
    Jump, 
}

/// Compile expression to an 8 bit instruction.
/// ### Errors
/// Returns error on parse faliure. Potential errors depend on 
/// instruction type. 
/// 
/// Error kinds include:
/// - Invalid operation.
/// - Invalid target registry.
/// - Invalid source registry.
/// - Invalid immidiate value.
/// - Invalid jump address.
/// - Invalid system call code.
/// 
/// ### Instruction Encoding
/// | **Type** | **Encoding** |
/// |:---------|:-------------|
/// | Arithmetic | `op<7:5>, rs<4:3>, rt<2:1>, imm<0>` |
/// | Jump | `op<7:5>, addr<4:0>` |
pub fn run(expression: &str) -> Result<u8, String> {

    let mut components = expression.split_whitespace();

    let mut instruction: Vec<bool> = Vec::with_capacity(INSTRUCTION_LENGTH);

    // parse instruction type and operation code
    let i_type = match get_op_and_i_type(components.next()) {
        Ok((_i_type, _op)) => {
            instruction.extend_from_slice(&_op);
            _i_type
        },
        Err(_msg) => return Err(_msg)
    };

    // parse target registry, source registry and immidiate value
    if i_type == InstructionType::Arithmetic {
        match get_rt_and_rs(components.next(), components.next(), components.next()) {
            Ok((_rs, _rt, _imm)) => {
                instruction.extend_from_slice(&_rs);
                instruction.extend_from_slice(&_rt);
                instruction.push(_imm);
            },
            Err(_msg) => return Err(_msg)
        }
    };

    // parse jump address
    if i_type == InstructionType::Jump {
        let err_msg = match i_type {
            InstructionType::Jump => "Invalid jump address.",
            _ => "Invalid system call code."
        };

        match components.next() {
            Some(_addr) => {
                match _addr.parse::<isize>() {
                    Ok(__addr) => {
                        let mut ___addr = __addr.abs();
                        for _i in (0..ADDR_LENGTH).rev() {
                            let comp = (2 as isize).pow(_i as u32);
                            instruction.push(if ___addr >= comp {
                                ___addr -= comp;
                                true
                            } else {
                                false
                            });
                        }
                    },
                    Err(_) => return Err(err_msg.to_string())
                }
            },
            None => return Err(err_msg.to_string())
        }
    };

    // parse to u8
    let mut exec_instr: u8 = 0;
    for _i in 0..8 {
        exec_instr += 2.pow(_i as u8);
    }

    Ok(exec_instr)
}

/// Parse operation and instruction type.
fn get_op_and_i_type(instr: Option<&str>) -> Result<(InstructionType, OperationCode), String> {
    match instr {
        Some(ref _op) if _op == &"add" => Ok((InstructionType::Arithmetic, ADD_OP)),
        Some(ref _op) if _op == &"sub" => Ok((InstructionType::Arithmetic, SUB_OP)),
        Some(ref _op) if _op == &"set" => Ok((InstructionType::Arithmetic, SET_OP)),
        Some(ref _op) if _op == &"j" => Ok((InstructionType::Jump, J_OP)),
        Some(ref _op) if _op == &"jeq" => Ok((InstructionType::Arithmetic, JEQ_OP)),
        Some(ref _op) if _op == &"cal" => Ok((InstructionType::Jump, CAL_OP)),
        _ => return Err("Invalid operation.".to_string())
    }
}

/// Parse target and source registry.
fn get_rt_and_rs(rt: Option<&str>, rs: Option<&str>, imm: Option<&str>)
 -> Result<(Registry, Registry, bool), String> {
    let _rt = get_r(rt);
    let _rs = get_r(rs);

    if _rt.is_none() {
        Err("Invalid target registry.".to_string())
    } else if _rs.is_none() {
        Err("Invalid source registry.".to_string())
    } else if imm.is_none() {
        Err("Invalid immidiate value.".to_string())
    } else {
        match imm.unwrap().parse::<usize>() {
            Ok(_imm) => Ok((_rs.unwrap(), _rt.unwrap(), if _imm % 2 > 0 {
                true
            } else {
                false
            })),
            Err(_) => Err("Invalid immidiate value.".to_string())
        }
    }
}

/// Parse registry.
fn get_r(r: Option<&str>) -> Option<Registry> {
    match r {
        Some("#0") => Some(R0),
        Some("#1") => Some(R1),
        Some("#2") => Some(R2),
        Some("#3") => Some(R3),
        _ => None
    }
}
