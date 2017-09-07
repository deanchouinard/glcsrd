defmodule GlcsrdWeb.ApiController do
  use GlcsrdWeb, :controller

  def show(conn, _params) do

    readings = Glcsrd.Readings.get()
    rd_list = :ets.foldr(fn({_, x} = y, list) -> [x | list] end, [], readings)
    json conn, %{items: rd_list}
  end

end

