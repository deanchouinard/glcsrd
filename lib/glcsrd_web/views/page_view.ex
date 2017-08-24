defmodule GlcsrdWeb.PageView do
  use GlcsrdWeb, :view

  def show_reading(reading) do
    %{date: date, time: time, value: value} = reading
    "#{date} #{time} #{value}"
  end

  def display_readings(readings) do
    Enum.map(readings, &show_reading(&1))
    |> Poison.encode!
  end

end
