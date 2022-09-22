defmodule FizzbuzzWeb.PageView do
  use FizzbuzzWeb, :view

  def is_favorite?(favorites, n) do
    favorites
    |> Enum.filter(fn %{number: filter_n} -> n == filter_n end)
    |> Enum.any?()
  end

  def is_prev_page_valid?(%{prev_page: 0, page_size: _page_size}), do: false
  def is_prev_page_valid?(%{prev_page: prev_page}) when prev_page > 0, do: true

  def is_next_page_valid?(%{page: page, last_page: last_page}) when page == last_page,
    do: false

  def is_next_page_valid?(%{
        next_page: next_page_counter,
        page_size: page_size,
        last_page: last_page
      })
      when next_page_counter <= last_page,
      do: next_page_counter * page_size <= Fizzbuzz.get_maximum_value()
end
