# DD1337 Week 3-4

## Chess Project

The time has come to flex your newly found Rust skills by writing a killer ass chess engine. This and the next weeks' homework is to implement the logic for a chess game:
- whose turn it is
- how pieces can move
- [check](https://en.wikipedia.org/wiki/Check_(chess))
- [promotion](https://en.wikipedia.org/wiki/Promotion_(chess))

_(optional)_ Implement special moves:
- [castling](https://en.wikipedia.org/wiki/Castling)
- [en passant](https://en.wikipedia.org/wiki/En_passant)
- [checkmate](https://en.wikipedia.org/wiki/Checkmate)
- [dead postion](https://en.wikipedia.org/wiki/Glossary_of_chess#dead_position)

The idea is that this library could be used by a chess GUI application. Therefore, privatise all resources in you library but the following public functions in the public struct `Game`:

| **Function** | **Description** |
|--------------|-----------------|
| `pub fn new() -> Game` | Initialises a new board with pieces. |
| `pub fn make_move(&mut self, _from: String, _to: String) -> Option<GameState>` | If the current game state is `InProgress` and the move is legal, move a piece and return the resulting state of the game. |
| `pub fn set_promotion(&mut self, _piece: String) -> ()` | Set the piece type that a peasant becames following a promotion. |
| `pub fn get_game_state(&self) -> GameState` | Get the current game state. |
| `pub fn get_possible_moves(&self, _position: String) -> Optional<Vec<String>>` | If a piece is standing on the given tile, return all possible new positions of that piece. Don't forget to the rules for check. _(optional)_ Don't forget to include en passent and castling. |

Positions are given as strings with the format `"<file><rank>"`.

Your program also exports an enumerable `GameState` with the values:
- `InProgress`, 
- `Check`,
- `GameOver`, 
- _(optional)_ `Checkmate` and
- _(optional)_ `DeadPosition`.

### Prepare assignment

1) Create a repository named `<KTH_ID>-chess` under the `INDAPlus20` organisation and clone it.
2) Navigate into your newly created repository and initialise a Rust library crate with the following command.
```bash
cargo init --lib
```

See the template crate for help with code setup.

### Grading

Since your crate is of type library, we cannot simply test it by running it. Instead, test your application with Rust unit tests. 

The grading on this assignment is based on how well the tests demonstrates the full functionality and game mechanics of your chess engine. The tests are expected to not fail, and print a representation of the board in the case of move demonstrations. _Test at least all of your implemented functionality from the lists above to prove implementation._

Run your unit tests with comments by entering the following command in your terminal:
```
cargo test -- --nocapture --test-threads=1
```