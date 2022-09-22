defmodule FizzbuzzWeb.FallbackController do
  use FizzbuzzWeb, :controller
  alias FizzbuzzWeb.ErrorView
  alias FizzbuzzWeb.ChangesetView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(ErrorView)
    |> render(:"403")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:validate_page_size, false}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.html", message: "Invalid Page Size.")
  end

  def call(conn, {:validate_positive, false}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.html", message: "Positive pages only !")
  end

  def call(conn, {:validate_page, :error}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.html", message: "Invalid pages.")
  end
end
