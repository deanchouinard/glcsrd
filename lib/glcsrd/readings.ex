defmodule Glcsrd.Readings do
  def get do
    readings = :ets.new(:readings, [:set])
    files = Path.wildcard("../data/*_glucose.csv")
    for file <- files do
      File.stream!(file)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.filter(fn(x) -> x != "" end)
      |> Enum.map(&String.split(&1, ","))
      #|> Enum.map(&{&1})
      |> IO.inspect
      |> Enum.map(&process(&1, readings))
      |> IO.inspect
    end
    readings
  end
  
  def process(line, readings) do
    [date, time, value] = Enum.map(line, &String.trim(&1))
    #   {date, time, value}
    key = "#{date}-#{time}"
    valuem = %{date: date, time: time, value: value}
    :ets.insert(readings, {key, valuem})
    # %{date: date, time: time, value: value}
  end
end

