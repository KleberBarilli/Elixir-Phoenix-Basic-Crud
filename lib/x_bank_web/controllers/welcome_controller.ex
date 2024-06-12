defmodule XBankWeb.WelcomeController do
  use XBankWeb, :controller

  def index(conn, _params) do

    conn
     |> put_status(:ok)
     |> json(%{message: "Welcome to XBank API"})
  end
end
