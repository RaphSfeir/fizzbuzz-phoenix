defmodule Fizzbuzz do
  @moduledoc """
  Fizzbuzz keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @maximum_value 100_000_000_000

  @doc """
  Get maximum value defined for this exercice
  """
  def get_maximum_value(), do: @maximum_value

  @doc """
  Public interface to apply Fizz buzz function to an integer.
  Returns an error for non positive, non zero integers.
  """
  def transform(n) when is_integer(n) and n > 0, do: {:ok, run(n)}
  def transform(other_values), do: {:error, {:invalid_value, other_values}}

  def transform!(n) do
    case transform(n) do
      {:ok, result} ->
        result

      {:error, {:invalid_value, value}} ->
        raise ArgumentError, message: "Invalid value: #{value}"
    end
  end

  def transform_list(list) when is_list(list),
    do:
      list
      |> Enum.map(fn n -> {n |> transform!(), n} end)

  def transform_list(other_values), do: {:error, {:invalid_list, other_values}}

  defp run(n) when rem(n, 15) == 0, do: "FizzBuzz"
  defp run(n) when rem(n, 5) == 0, do: "Buzz"
  defp run(n) when rem(n, 3) == 0, do: "Fizz"
  defp run(n), do: n
end
