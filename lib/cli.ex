defmodule Glcsrd.CLI do
  def run do
    IO.puts "HELLO"
    readings = :ets.new(:readings, [:set])
    
    File.stream!("glcsrd.txt")
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.filter(fn(x) -> x != "" end)
    |> Enum.map(&String.split(&1, ","))
    #|> Enum.map(&{&1})
    |> IO.inspect
    |> Enum.each(&process(&1, readings))

    rd_list = :ets.foldr(fn(x, list) -> [x | list] end, [], readings)
    IO.inspect rd_list
  end

  def process(line, readings) do
    [date, time, value] = line
    IO.puts("Date: #{date} #{time} #{value}")
    [month, day, year] = String.split(date, "/")
    key = "#{year}-#{month}-#{day}-#{String.trim(time)}"
    IO.puts(key)

    :ets.insert(readings, {key, value})

  end

end

