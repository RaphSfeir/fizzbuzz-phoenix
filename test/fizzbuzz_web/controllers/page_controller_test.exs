defmodule FizzbuzzWeb.PageControllerTest do
  use FizzbuzzWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to FizzBuzz!"
  end
end
