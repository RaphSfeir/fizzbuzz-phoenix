defmodule Fizzbuzz.Pagination do
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
end
