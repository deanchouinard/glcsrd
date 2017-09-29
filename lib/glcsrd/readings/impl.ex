defmodule Glcsrd.Readings.Impl do
  def get do

  end

  def load(dir) do
    #readings = :ets.new(:readings, [:set])
    glucose_readings = read_files("#{dir}*_glucose.csv")
    weight_readings = read_files("#{dir}*_weight.csv")
    # IO.inspect(glucose_readings, label: "glucose_readings")
    # IO.inspect(weight_readings, label: "weight_readings")
    # r_diff = glucose_readings -- weight_readings
    # IO.inspect(r_diff, label: "diff")
    
    # fill in missing weight dates with nil to sync indexes of both datasets
    weight_readings = Enum.map(glucose_readings, &match_lists(&1,
      weight_readings))

    %{ dir: dir, readings: %{ glucose: glucose_readings, weight:
        weight_readings}}
  end

  
  defp match_lists(aitem, listb) do
    found = Enum.find(listb, 0, &is_match(&1, aitem))
    case found do
      0 -> %{aitem | :value => nil}
      _ -> found
    end
  end

  defp is_match(a, b) do
    %{date: adate, time: _, value: _} = a
    %{date: bdate, time: _, value: _} = b
    adate == bdate
  end

  defp read_files(file_spec) do
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
    #readings

  end

  defp process(line) do
    [date, time, value] = Enum.map(line, &String.trim(&1))
    #   {date, time, value}
    # key = "#{date}-#{time}"
    # valuem = %{date: date, time: time, value: value}
    # :ets.insert(readings, {key, valuem})
    %{date: date, time: time, value: value}
  end
end

