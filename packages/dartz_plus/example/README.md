# Dartz Plus Example

This example Flutter app demonstrates how to use the `dartz_plus` package with the `Either` type.

## Running the Example

1. Make sure you're in the `example` directory:
   ```bash
   cd example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Examples Demonstrated

The example app includes interactive demonstrations of:

1. **Basic Usage** - Creating and checking `Either` values
2. **Error Handling** - Using `Either` for type-safe error handling
3. **Transformation** - Using `map`, `mapLeft`, and `bimap` to transform values
4. **Chaining Operations** - Using `flatMap` to chain operations
5. **getOrElse & orElse** - Getting values with defaults and alternatives
6. **Async Operations** - Using `foldAsync` for asynchronous operations

Each example shows the output in a scrollable text area, making it easy to understand how each method works.

