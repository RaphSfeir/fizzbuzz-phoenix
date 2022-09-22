defmodule Fizzbuzz.PaginationTest do
  use FizzbuzzWeb.ConnCase
  alias Fizzbuzz.Pagination

  describe "page_params_to_range/2" do
    test "success: create basic range with 50 items" do
      assert 1 == Pagination.page_params_to_range(1, 50) |> List.first()
      assert 50 == Pagination.page_params_to_range(1, 50) |> List.last()
    end

    test "success: create appropriate ranges with different values" do
      page = 250
      size = 5
      assert page * size - size == Pagination.page_params_to_range(page, size) |> List.first()
      assert page * size == Pagination.page_params_to_range(page, size) |> List.last()
    end
  end

  test "get_last_page_number/1" do
    assert 1_000_000_000 == Pagination.get_last_page_number(100)
  end

  describe "validate_page_params/2" do
    test "success: valid parameters return valid map" do
      valid_page_params = %{"page" => "250", "page_size" => "100"}

      assert {:ok, %{list_numbers: _, page: 250, page_size: 100}} =
               valid_page_params
               |> Pagination.validate_page_params()
    end

    test "fails: negative page return page validation error" do
      valid_page_params = %{"page" => "-1", "page_size" => "100"}

      assert {:validate_positive, false} =
               valid_page_params
               |> Pagination.validate_page_params()
    end

    test "fails: invalid page size" do
      valid_page_params = %{"page" => "123", "page_size" => "101"}

      assert {:validate_page_size, false} =
               valid_page_params
               |> Pagination.validate_page_params()
    end
  end
end
