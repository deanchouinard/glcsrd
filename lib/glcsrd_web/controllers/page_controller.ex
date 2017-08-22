defmodule GlcsrdWeb.PageController do
  use GlcsrdWeb, :controller

  def index(conn, _params) do
    readings = Glcsrd.CLI.run()
    render conn, "index.html", readings: readings
  end
end
