defmodule FizzbuzzWeb.PageController do
  use FizzbuzzWeb, :controller

  action_fallback FizzbuzzWeb.FallbackController

  def index(conn, params = %{"page" => _raw_page, "page_size" => _raw_page_size}) do
    render_index(conn, params, "html")
  end

  def index(conn, _) do
    conn
    |> index(%{"page" => "1", "page_size" => "100"})
  end

  def render_index(conn, _params = %{"page" => raw_page, "page_size" => raw_page_size}, view_type) do
    with {:validate_page, {page, _}} <- {:validate_page, Integer.parse(raw_page)},
         {:validate_page, {page_size, _}} <- {:validate_page, Integer.parse(raw_page_size)},
         list_numbers <- Fizzbuzz.Pagination.page_params_to_range(page, page_size) do
      render(conn, "index.#{view_type}",
        fizzbuzzed_values: list_numbers |> Fizzbuzz.transform_list(),
        favorites:
          Fizzbuzz.Favorites.list_favorites_in_range(
            List.first(list_numbers),
            List.last(list_numbers)
          ),
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
end
