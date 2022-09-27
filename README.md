# Fizzbuzz

## Requirements
  
  * Elixir 1.12+
  * Persistancy is dealt using MySQL.

## Get started

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Files to consider

  * `fizzbuzz/pagination.ex` Deals with the pagination logic.
  * `fizzbuzz.ex` is where the FizzBuzz business logic is located. 
  * `favorites/favorite.ex` is the context for the Favorites entities. 
  * All tests are written in the `test/` directory.
  * Controllers were duplicated for the API pipeline as the data treatment differs when rendering output.
