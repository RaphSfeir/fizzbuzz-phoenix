defmodule FizzbuzzWeb.PageController do
  use FizzbuzzWeb, :controller

  action_fallback FizzbuzzWeb.FallbackController

  def index(conn, _params = %{"page" => raw_page, "page_size" => raw_page_size}) do
    with {:validate_page, {page, _}} <- {:validate_page, Integer.parse(raw_page)},
         {:validate_page, {page_size, _}} <- {:validate_page, Integer.parse(raw_page_size)} do
      render(conn, "index.html",
        values:
          Fizzbuzz.Pagination.page_params_to_range(page, page_size) |> Fizzbuzz.transform_list(),
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
end
