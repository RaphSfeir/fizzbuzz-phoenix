defmodule FizzbuzzWeb.PageControllerTest do
  use FizzbuzzWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to FizzBuzz!"
  end

  test "GET / with pagination still displays homepage", %{conn: conn} do
    conn = get(conn, "/", %{page: 1, page_size: 100})
    assert html_response(conn, 200) =~ "Welcome to FizzBuzz!"
  end

  test "GET / with different paginations contains appropriate values", %{conn: conn} do
    conn = get(conn, "/", %{page: 100_000, page_size: 100})
    assert html_response(conn, 200) =~ "9999900"
    assert html_response(conn, 200) =~ "9999901"

    conn = get(conn, "/", %{page: 30, page_size: 1})
    assert html_response(conn, 200) =~ "<td>\nFizzBuzz"
  end

  test "GET / with paginations contains pagination buttons", %{conn: conn} do
    conn = get(conn, "/", %{page: 1_000, page_size: 10})
    assert html_response(conn, 200) =~ "Last page"
    assert html_response(conn, 200) =~ "Next page"
    assert html_response(conn, 200) =~ "Prev page"
    assert html_response(conn, 200) =~ "First page"
  end

  test "GET / Last page doens't have next page ", %{conn: conn} do
    conn = get(conn, "/", %{page: 1_000_000_000, page_size: 100})
    assert html_response(conn, 200) =~ "First page"
    assert html_response(conn, 200) =~ "Prev page"
    assert !String.contains?(html_response(conn, 200), "Next page")
  end

  test "GET / First page doens't have prev page", %{conn: conn} do
    conn = get(conn, "/", %{page: 1, page_size: 100})
    assert html_response(conn, 200) =~ "Last page"
    assert html_response(conn, 200) =~ "Next page"
    assert !String.contains?(html_response(conn, 200), "Prev page")
  end

  test "GET / invalid pagination returns error", %{conn: conn} do
    conn = get(conn, "/", %{page: -1, page_size: 10})
    assert html_response(conn, 400) =~ "Positive pages only"
  end
end
