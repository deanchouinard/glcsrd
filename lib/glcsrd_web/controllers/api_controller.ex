defmodule GlcsrdWeb.ApiController do
  use GlcsrdWeb, :controller

  def show(conn, _params) do
    { glucose, weight} = Glcsrd.Readings.get()
    # rd_list = :ets.foldr(fn({_, x} = y, list) -> [x | list] end, [], readings)
    # rd_list = Enum.sort(rd_list, &(date_of(&1) <= date_of(&2)))
    # json conn, %{items: rd_list}
    json conn, %{items: %{glucose: glucose, weight: weight}}
  end

  def reload(conn, _params) do
    { glucose, weight} = Glcsrd.Readings.reload()
    json conn, %{items: %{glucose: glucose, weight: weight}}
  end

  defp date_of(line) do
    %{date: d, time: t, value: v} = line
    d
  end
end

