defmodule GlcsrdWeb.ApiController do
  use GlcsrdWeb, :controller

  def show(conn, _params) do

    json conn, %{items: Glcsrd.Readings.get()}
  end

end

