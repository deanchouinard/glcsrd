defmodule Glcsrd.Readings do
  def get do
    #readings = :ets.new(:readings, [:set])
    glucose_readings = read_files("../data/*_glucose.csv")
    weight_readings = read_files("../data/*_weight.csv")
    IO.inspect(glucose_readings, label: "glucose_readings")
    IO.inspect(weight_readings, label: "weight_readings")
    r_diff = glucose_readings -- weight_readings
    IO.inspect(r_diff, label: "diff")
    { glucose_readings, weight_readings }
  end
  
  def read_files(file_spec) do
    files = Path.wildcard(file_spec)
    readings = for file <- files do
      File.stream!(file)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.filter(fn(x) -> x != "" end)
      |> Enum.map(&String.split(&1, ","))
      #|> Enum.map(&{&1})
      |> Enum.map(&process(&1))
      |> IO.inspect(label: "line")

      # IO.inspect(file_data, label: "file data")
      # IO.inspect(readings, label: "readings_before")
      # readings = [file_data | readings]
      # IO.inspect(readings, label: "readings_for")
    end
    readings = List.flatten(readings)
    readings

  end

  def process(line) do
    [date, time, value] = Enum.map(line, &String.trim(&1))
    #   {date, time, value}
    # key = "#{date}-#{time}"
    # valuem = %{date: date, time: time, value: value}
    # :ets.insert(readings, {key, valuem})
    %{date: date, time: time, value: value}
  end
end

