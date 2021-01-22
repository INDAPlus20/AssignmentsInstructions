/**
 * Sorting visualisation example
 * Author: Viola Söderlund <violaso@kth.se>
 * Last updated: 2020-11-17
 */

use ggez::event;
use ggez::graphics::{self, Color};
use ggez::{Context, GameResult};

use std::path;

use rand::seq::SliceRandom;
use rand::thread_rng;

const ALG_SPAN: usize = 20;

const GRID_SIZE: (usize, usize) = (ALG_SPAN*2, 50);
const GRID_CELL_SIZE: usize = 10;

/// Size of the application window.
const SCREEN_SIZE: (f32, f32) = (
    GRID_SIZE.0 as f32 * GRID_CELL_SIZE as f32,
    GRID_SIZE.1 as f32 * GRID_CELL_SIZE as f32,
);

trait Sorter {
    fn new(list: &[Vec<usize>]) -> Self;
    fn sort(&mut self) -> &[Vec<usize>];
}

struct Selection {
    grid: Vec<Vec<usize>>,
    finished: bool,
    inner_step: usize,
    outer_step: usize
}

impl Sorter for Selection {
    fn new(list: &[Vec<usize>]) -> Selection {
        Selection {
            grid: list.to_vec(),
            finished: false,
            inner_step: 0,
            outer_step: 0
        }
    }

    fn sort(&mut self) -> &[Vec<usize>] {
        if !self.finished {
            for _col in 0..self.grid.len() {

                //#region Selection sort

                if self.grid[_col][self.inner_step + 1] < self.grid[_col][self.inner_step] {
                    self.grid[_col].swap(self.inner_step + 1, self.inner_step);
                }

                //#endregion
            }

            println!("{}", self.inner_step);

            if self.inner_step + 2 == GRID_SIZE.1 - self.outer_step {
                self.outer_step += 1;
                self.inner_step = 0;

                if self.outer_step == GRID_SIZE.1 {
                    self.finished = true;
                }
            } else {
                self.inner_step += 1;
            }
        }

        &self.grid
    }
}

struct Insertion {
    grid: Vec<Vec<usize>>,
    finished: bool,
    inner_step: usize,
    outer_step: usize,
    inner_saves: Vec<usize>,
    outer_saves: Vec<usize>,
    going: Vec<bool>
}

impl Sorter for Insertion {
    fn new(list: &[Vec<usize>]) -> Insertion {
        Insertion {
            grid: list.to_vec(),
            finished: false,
            inner_step: 1,
            outer_step: 1,
            inner_saves: vec![1; list.len()],
            outer_saves: list.iter().map(|_col| _col[1]).collect(),
            going: vec![true; list.len()]
        }
    }

    fn sort(&mut self) -> &[Vec<usize>] {
        if !self.finished {
            if self.inner_step >= 1 {
                for _col in 0..self.grid.len() {

                    //#region Insertion sort

                    if self.going[_col] {
                        if self.outer_saves[_col] < self.grid[_col][self.inner_step - 1] {
                            self.grid[_col][self.inner_step] = self.grid[_col][self.inner_step - 1];
                            self.inner_saves[_col] = self.inner_step - 1;
                        } else {
                            self.going[_col] = false;
                        }
                    }

                    //#endregion
                }
            }

            if self.inner_step == 0 || !self.going.contains(&true) {
                if self.outer_step + 1 == GRID_SIZE.1 {
                    self.finished = true;
                } else {
                    for _col in 0..self.grid.len() {
                        self.grid[_col][self.inner_saves[_col]] = self.outer_saves[_col];
                        self.outer_saves[_col] = self.grid[_col][self.outer_step + 1];
                        self.going[_col] = true;
                        self.inner_saves[_col] = self.outer_step + 1;
                    }
    
                    self.outer_step += 1;
                    self.inner_step = self.outer_step;
                }
                
            } else {
                self.inner_step -= 1;
            }
        }

        &self.grid
    }
}

struct Merge {
    grid: Vec<Vec<usize>>,
    finished: bool,
    part_length: usize,
    inner_step_left: usize,
    inner_step_right: usize,
    outer_step: usize,
    left: Vec<Vec<usize>>,
    right: Vec<Vec<usize>>,
    left_dir: bool
}

impl Sorter for Merge {
    fn new(list: &[Vec<usize>]) -> Merge {
        Merge {
            grid: list.to_vec(),
            finished: false,
            inner_step: 0,
            outer_step: 0,
            part_length: 1
        }
    }

    fn sort(&mut self) -> &[Vec<usize>] {
        // outer step - partition counter
        // inner step - index in partition
        // part_length - length of partition
        // finnished - inner step done and part length equals GRIDSIZE
        if !self.finished {
            for _col in 0..self.grid.len() {

                //#region Selection sort

                if 

                //#endregion
            }

            println!("{}", self.inner_step);

            if self.inner_step + 1 == GRID_SIZE.1 / 2_usize.pow((self.part_step) as u32) {
                self.part_step += 1;
                self.inner_step = 0;

                if 2_usize.pow(self.part_step as u32) >= GRID_SIZE.1 {
                    self.finished = true;
                }
            } else {
                self.inner_step += 1;
            }
        }

        &self.grid
    }
}

/// GUI logic and event implementation structure. 
struct AppState {
    selection: Selection,
    insertion: Insertion,
    //merge: Merge,
    colours: Vec<Color>,
    grid: Vec<Vec<usize>>,

    insertion_step: usize,
    selection_step: usize,
    merge_step: usize,
    merge_stack: Vec<Vec<usize>>
}

impl AppState {
    const INSERTION_START: usize = 0;
    const INSERTION_END: usize = ALG_SPAN;
    const SELECTION_START: usize = Self::INSERTION_END;
    const SELECTION_END: usize = ALG_SPAN*2;
    const MERGE_START: usize = Self::SELECTION_END;
    const MERGE_END: usize = ALG_SPAN*3;

    /// Initialise new shuffled grid.
    fn new() -> GameResult<AppState> {
        let grid = Self::generate_grid();

        let state = AppState {
            selection: Selection::new(&grid[Self::SELECTION_START..Self::SELECTION_END]),
            insertion: Insertion::new(&grid[Self::INSERTION_START..Self::INSERTION_END]),
            grid,
            colours: (0..GRID_SIZE.1).map(|_i| {
                let h: f32 = 360.0 * (_i as f32)/(GRID_SIZE.1 as f32);
                let h_ = if h == 360.0 { 0.0 } else { h / 60.0 };
                let x = h_ - h_.floor();

                let q = 1.0 - x;
                let t = 1.0 - q;

                let (r, g, b) = match h_.floor() as usize {
                    0 => (1.0, t, 0.0),
                    1 => (q, 1.0, 0.0),
                    2 => (0.0, 1.0, t),
                    3 => (0.0, q, 1.0),
                    4 => (t, 0.0, 1.0),
                    5 => (1.0, 0.0, q),
                    _ => (0.0, 0.0, 0.0)
                };
                
                Color::new(r, g, b, 1.0)
            }).collect(),

            insertion_step: 0,
            selection_step: 0,
            merge_step: 0,
            merge_stack: Vec::new()
        };

        Ok(state)
    }

    /// Get grid of format `vec![vec![usize; GRID_SIZE.1]; GRID_SIZE.0]` representing a colour spectrum.
    fn generate_grid() -> Vec<Vec<usize>> {
        let mut random_gen = thread_rng();

        (0..GRID_SIZE.0).map(|_| {
            let mut colours: Vec<usize> = (0..GRID_SIZE.1).collect();
            colours.shuffle(&mut random_gen);
            colours
        }).collect()
    }

    fn sort(&mut self) -> bool {
        let sorted = self.selection.sort();
        for _col in Self::SELECTION_START..Self::SELECTION_END {
            for _i in 0..GRID_SIZE.1 {
                self.grid[_col][_i] = sorted[_col - Self::SELECTION_START][_i];
            }
        }
        let sorted = self.insertion.sort();
        for _col in Self::INSERTION_START..Self::INSERTION_END {
            for _i in 0..GRID_SIZE.1 {
                self.grid[_col][_i] = sorted[_col - Self::INSERTION_START][_i];
            }
        }

        self.selection.finished
    }

    fn merge_sort_step(&mut self) {
        /*
         if length(A) <= 1 then
            return A
        left ← empty list
        right ← empty list
        i ← 0
        while i < length(A)
            if i < length(A)/2 then
                add A[i] to left
            else
                add A[i] to right
            end if
            i ← i + 1
        end while
        left ← merge sort left
        right ← merge sort right
        return concatinate left and right
         */

        if self.merge_step < GRID_SIZE.1 - 1 {
            for _col in Self::MERGE_START..Self::MERGE_END {

                //#region Merge sort

                let list = match self.merge_stack.pop() {
                    Some(_list) if !_list.len() > 1 => _list,
                    Some(_list) => {
                        self.merge_stack.push(_list);
                        continue;
                    }
                    _ => {
                        self.merge_stack.push(Vec::new());
                        continue;
                    }
                };

                let mut left: Vec<usize> = Vec::with_capacity(list.len()/2);
                for _i in 0..(list.len()/2) {
                    left.push(self.grid[_col][_i]);
                }
                let mut right: Vec<usize> = Vec::with_capacity(list.len()/2);
                for _i in (list.len()/2)..list.len() {
                    right.push(self.grid[_col][_i]);
                }



                self.merge_stack.push(left);
                self.merge_stack.push(right);

                //#endregion
            }

            self.selection_step += 1;
        } 
        else if self.merge_step < GRID_SIZE.1 {
            self.merge_step += 1;
        } 
        else {
            self.merge_step = 0;
        }
    }

    /// Make one step using insertion sort.
    /// 
    /// See https://en.wikipedia.org/wiki/Insertion_sort).
    fn selection_sort_step(&mut self) {

        if self.selection_step < GRID_SIZE.1 - 1 {
            for _col in Self::SELECTION_START..Self::SELECTION_END {

                //#region Selection sort

                let mut min_index = self.selection_step;

                for _j in (self.selection_step+1)..(GRID_SIZE.0) {
                    if self.grid[_col][_j] < self.grid[_col][min_index] {
                        min_index = _j;
                    }
                }

                if min_index != self.selection_step {
                    self.grid[_col].swap(self.selection_step, min_index);
                }

                //#endregion
            }

            self.selection_step += 1;
        } 
        else if self.selection_step < GRID_SIZE.1 {
            self.selection_step += 1;
        } 
        else {
            self.selection_step = 0;
        }
    }

    /// Make one step using insertion sort.
    /// 
    /// See https://en.wikipedia.org/wiki/Insertion_sort).
    fn insertion_sort_step(&mut self) {
        if self.insertion_step < GRID_SIZE.1 {
            for _col in Self::INSERTION_START..Self::INSERTION_END {

                //#region Insertion sort

                let x = self.grid[_col][self.insertion_step];
                
                let mut _j = self.insertion_step;
                while _j >= 1 && x < self.grid[_col][_j - 1] {
                    self.grid[_col][_j] = self.grid[_col][_j - 1];
                    _j -= 1;
                }

                self.grid[_col][_j] = x;

                //#endregion
            }

            self.insertion_step += 1;
        } else {
            self.insertion_step = 0;
        }
    }
}

/// Implement each stage of the application event loop. 
impl event::EventHandler for AppState {

    /// For updating game logic, which front-end doesn't handle.
    fn update(&mut self, _ctx: &mut Context) -> GameResult {
        //self.insertion_sort_step();
        //self.selection_sort_step();
        if self.sort() {
            self.grid = Self::generate_grid();
        }

        //if self.insertion_step == 0 && self.selection_step == 0 {
        //    self.grid = Self::generate_grid();
        //}

        Ok(())
    }

    /// Draw interface, i.e. draw game board
    fn draw(&mut self, ctx: &mut Context) -> GameResult {
        // clear interface with gray background colour
        graphics::clear(ctx, [0.5, 0.5, 0.5, 1.0].into());

        // draw tiles
        for _row in 0..GRID_SIZE.1 {
            for _col in 0..GRID_SIZE.0 {
                let rectangle = graphics::Mesh::new_rectangle(ctx, 
                    graphics::DrawMode::fill(), 
                    graphics::Rect::new_i32(
                        ((_col) as i32) * (GRID_CELL_SIZE as i32),
                        ((_row) as i32) * (GRID_CELL_SIZE as i32),
                        GRID_CELL_SIZE as i32,
                        GRID_CELL_SIZE as i32,
                    ), self.colours[self.grid[_col][_row]])?;
                graphics::draw(ctx, &rectangle, (ggez::mint::Point2 { x: 0.0, y: 0.0 }, ));
            }
        }

        // render updated graphics
        graphics::present(ctx)?;

        Ok(())
    }
}

pub fn main() -> GameResult {
    let resource_dir = path::PathBuf::from("./resources");

    let context_builder = ggez::ContextBuilder::new("sorting-visualisation", "violaso")
        .add_resource_path(resource_dir)        // Import image files to GGEZ
        .window_setup(
            ggez::conf::WindowSetup::default()  
                .title("Sorting Visualisation") // Set window title "Schack"
        )
        .window_mode(
            ggez::conf::WindowMode::default()
                .dimensions(SCREEN_SIZE.0, SCREEN_SIZE.1) // Set window dimenstions
                .resizable(false)               // Fixate window size
        );
    let (contex, event_loop) = &mut context_builder.build()?;

    let state = &mut AppState::new()?;
    event::run(contex, event_loop, state)       // Run window event loop
}