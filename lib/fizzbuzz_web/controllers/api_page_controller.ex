defmodule FizzbuzzWeb.ApiPageController do
  use FizzbuzzWeb, :controller

  action_fallback FizzbuzzWeb.FallbackController
  alias Fizzbuzz.Favorites.Favorite

  def index(conn, _params = %{"page" => raw_page, "page_size" => raw_page_size}) do
    with {:validate_page, {page, _}} <- {:validate_page, Integer.parse(raw_page)},
         {:validate_page, {page_size, _}} <- {:validate_page, Integer.parse(raw_page_size)},
         list_numbers <- Fizzbuzz.Pagination.page_params_to_range(page, page_size) do
      render(conn, "index.json",
        fizzbuzzed_values:
          list_numbers |> Fizzbuzz.transform_list() |> Enum.map(&format_values_json/1),
        favorites:
          Fizzbuzz.Favorites.list_favorites_in_range(
            List.first(list_numbers),
            List.last(list_numbers)
          )
          |> Enum.map(&extract_number_from_favorite/1),
        pagination: %{
          page: page,
          page_size: page_size,
          next_page: page + 1,
          prev_page: page - 1,
          last_page: Fizzbuzz.Pagination.get_last_page_number(page_size)
        }
      )
    end
  end

  def index(conn, _) do
    conn
    |> index(%{"page" => "1", "page_size" => "100"})
  end

  defp extract_number_from_favorite(%Favorite{number: number}), do: number
  defp format_values_json({fb_n, _n}), do: fb_n
end
