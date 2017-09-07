defmodule Glcsrd.CLI do
  def run do
    # IO.puts "HELLO"
    # readings = :ets.new(:readings, [:set])
    
    Glcsrd.Readings.get()
    # |> Enum.each(&process(&1, readings))

    # rd_list = :ets.foldr(fn(x, list) -> [x | list] end, [], readings)
    # IO.inspect rd_list
  end


  def process(line, readings) do
    [date, time, value] = Enum.map(line, &String.trim(&1))
    IO.puts("Date: #{date} #{time} #{value}")
    [year, month, day] = String.split(date, "-")
    key = "#{year}-#{month}-#{day}-#{String.trim(time)}"
    IO.puts(key)

    :ets.insert(readings, {key, value})

  end

end

