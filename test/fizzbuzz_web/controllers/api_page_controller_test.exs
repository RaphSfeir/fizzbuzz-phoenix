defmodule FizzbuzzWeb.ApiPageControllerTest do
  use FizzbuzzWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "GET / has proper keys and default pages", %{conn: conn} do
    conn = get(conn, Routes.api_page_path(conn, :index))

    assert %{
             "favorites" => _,
             "fizzbuzzed_values" => _,
             "pagination" => %{
               "last_page" => 1_000_000_000,
               "next_page" => 2,
               "page" => 1,
               "page_size" => 100,
               "prev_page" => 0
             }
           } = json_response(conn, 200)
  end

  test "GET / pagination working properly", %{conn: conn} do
    conn = get(conn, Routes.api_page_path(conn, :index, %{page: 500, page_size: 50}))

    assert %{
             "favorites" => _,
             "fizzbuzzed_values" => _,
             "pagination" => %{
               "last_page" => 2_000_000_000,
               "next_page" => 501,
               "page" => 500,
               "page_size" => 50,
               "prev_page" => 499
             }
           } = json_response(conn, 200)
  end

  test "GET / missing param redirects to default", %{conn: conn} do
    conn = get(conn, Routes.api_page_path(conn, :index, %{page_size: 100}))
    assert %{} = json_response(conn, 200)
  end

  test "GET / invalid page size returns error", %{conn: conn} do
    conn = get(conn, Routes.api_page_path(conn, :index, %{page: 500, page_size: 5}))
    assert "Bad Request" = json_response(conn, 400)
  end

  test "GET / invalid page returns error", %{conn: conn} do
    conn = get(conn, Routes.api_page_path(conn, :index, %{page: "hi", page_size: 100}))
    assert "Bad Request" = json_response(conn, 400)
  end
end
