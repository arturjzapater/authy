defmodule AuthyWeb.PageController do
  use AuthyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
