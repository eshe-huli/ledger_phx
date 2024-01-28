defmodule LedgerPhxWeb.PageController do
  use LedgerPhxWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def home_api(conn, _params) do
    send_resp(conn, 200, "Hello World")
  end
end
