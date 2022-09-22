defmodule Fizzbuzz.Pagination do
  @accepted_page_size [10, 25, 50, 100, 500]
  def page_params_to_range(1, page_size)
      when is_integer(page_size) do
    end_index = min(page_size, Fizzbuzz.get_maximum_value())
    # Make sure we start at 1 and not 0
    1..end_index |> Enum.to_list()
  end

  def page_params_to_range(page, page_size)
      when is_integer(page) and is_integer(page_size) and page > 0 do
    start_index = (page - 1) * page_size
    end_index = min(page * page_size, Fizzbuzz.get_maximum_value())
    start_index..end_index |> Enum.to_list()
  end

  def get_last_page_number(page_size) do
    round(Fizzbuzz.get_maximum_value() / page_size)
  end

  def get_accepted_page_size(), do: @accepted_page_size

  def validate_page_params(%{"page" => raw_page, "page_size" => raw_page_size} = _raw_page_params) do
    with {:validate_page, {page, _}} <- {:validate_page, Integer.parse(raw_page)},
         {:validate_page, {page_size, _}} <- {:validate_page, Integer.parse(raw_page_size)},
         {:validate_positive, true} <- {:validate_positive, page > 0},
         {:validate_page_size, true} <-
           {:validate_page_size, @accepted_page_size |> Enum.member?(page_size)},
         list_numbers <- Fizzbuzz.Pagination.page_params_to_range(page, page_size) do
      {:ok, %{list_numbers: list_numbers, page: page, page_size: page_size}}
    else
      fallback -> fallback
    end
  end
end
