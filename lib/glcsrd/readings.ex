defmodule Glcsrd.Readings do
  def get do
    File.stream!("glcsrd.txt")
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.filter(fn(x) -> x != "" end)
    |> Enum.map(&String.split(&1, ","))
    #|> Enum.map(&{&1})
    |> IO.inspect
    |> Enum.map(&process(&1))
    |> IO.inspect

  end
  
  def process(line) do
    [date, time, value] = Enum.map(line, &String.trim(&1))
    #   {date, time, value}
    %{date: date, time: time, value: value}
  end
end

