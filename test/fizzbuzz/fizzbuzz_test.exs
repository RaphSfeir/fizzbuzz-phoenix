defmodule FizzbuzzTest do
  use ExUnit.Case

  @hardcoded_fizzbuzz [
    1,
    2,
    "Fizz",
    4,
    "Buzz",
    "Fizz",
    7,
    8,
    "Fizz",
    "Buzz",
    11,
    "Fizz",
    13,
    14,
    "FizzBuzz",
    16,
    17,
    "Fizz",
    19,
    "Buzz",
    "Fizz",
    22,
    23,
    "Fizz",
    "Buzz",
    26,
    "Fizz",
    28,
    29,
    "FizzBuzz",
    31,
    32,
    "Fizz",
    34,
    "Buzz",
    "Fizz",
    37,
    38,
    "Fizz",
    "Buzz"
  ]

  describe "Fizzbuzz.transform!" do
    test "success: apply to small list of integers" do
      assert 1..40
             |> Enum.map(&Fizzbuzz.transform!/1) ==
               @hardcoded_fizzbuzz
    end

    test "success: apply to large list of integers" do
      1..100_000
      |> Enum.map(fn n ->
        # Second methood verification
        expected_value =
          cond do
            rem(n, 3) == 0 and rem(n, 5) == 0 ->
              "FizzBuzz"

            rem(n, 3) == 0 ->
              "Fizz"

            rem(n, 5) == 0 ->
              "Buzz"

            true ->
              n
          end

        assert expected_value == Fizzbuzz.transform!(n)
      end)
    end

    test "fails: invalid value" do
      assert_raise(ArgumentError, fn -> Fizzbuzz.transform!(1.1) end)
      assert_raise(ArgumentError, fn -> Fizzbuzz.transform!(false) end)
      assert_raise(ArgumentError, fn -> Fizzbuzz.transform!(-3) end)
      assert_raise(ArgumentError, fn -> Fizzbuzz.transform!("bonjour") end)
      assert_raise(ArgumentError, fn -> Fizzbuzz.transform!([1]) end)
    end
  end
end
