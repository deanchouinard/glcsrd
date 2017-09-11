defmodule GlcsrdWeb.PageController do
  use GlcsrdWeb, :controller

  def index(conn, _params) do
    {readings, _} = Glcsrd.Readings.get()
    # rd_list = :ets.foldr(fn({_, x} = y, list) -> [x | list] end, [], readings)
    # IO.inspect rd_list
    # IO.inspect(rd_list, label: "readings")
    # render conn, "index.html", readings: rd_list
    render conn, "index.html", readings: readings
  end
end
