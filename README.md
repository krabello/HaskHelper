# HaskHelper: Your Interactive Haskell Cheatsheet

Welcome to the Haskell Cheatsheet App! This application is designed to help you search and learn about various Haskell commands and concepts interactively through a command-line interface.

## Features

- **Interactive Search**: Search for Haskell commands and descriptions interactively.
- **Command Examples**: See example usage for each command with expected output.
- **Humorous Farewell**: Enjoy a bit of Haskell humor when you decide to quit the app.

## Prerequisites

- **GHC (The Glasgow Haskell Compiler)**: Make sure you have GHC installed. You can download it from [here](https://www.haskell.org/ghc/).
- **Cabal or Stack**: Use Cabal or Stack to manage your Haskell packages. You can install them from [here](https://www.haskell.org/cabal/) or [here](https://docs.haskellstack.org/en/stable/README/).

## Installation

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/your-username/haskell-cheatsheet-app.git
   cd haskell-cheatsheet-app
   ```

## Install Dependencies

if you are using Cabal:
  ```sh
  cabal install
  ```

If you are using Stack:
  ```sh
  stack setup
  stack build
  ```

## Running the App

If you are using Cabal:
  ```sh
  cabal run
  ```

If you are using Stack:
  ```sh
  stack run
  ```
## Usage

- Run the app, and you will be prompted to enter a Haskell command or description to search.
- Type in your search term and press Enter.
- To quit the app, type `q` and press Enter.

## Commands List

Here are some of the commands you can search for:

- `import`: Import a module.
- `let`: Define a local variable.
- `data`: Define a new data type.
- `map`: Apply a function to each element of a list.
- `filter`: Filter a list based on a predicate.
- `foldl`: Left fold of a list.
- `foldr`: Right fold of a list.
- `++`: Concatenate two lists.
- `!!`: Index into a list.
- `head`: Get the first element of a list.
- `tail`: Get all elements of a list except the first.
- `length`: Get the length of a list.
- `reverse`: Reverse a list.
- `sum`: Sum the elements of a list.
- `product`: Multiply the elements of a list.

...and many more!

### Example

  ```sh
  Enter a command or description to search (q to quit): map

  Command: map
  Description: Apply a function to each element of a list
  Example: map (+1) [1, 2, 3] -- output [2, 3, 4]
```

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Inspired by the need for an interactive and fun way to learn Haskell commands.
- Utilizes the [Haskeline](https://hackage.haskell.org/package/haskeline) library for command-line input handling.

Enjoy learning Haskell with the HaskHelper App!
