defmodule Config do

  def read_config do
    File.stream!(Path.join(File.cwd!, "config.conf"))
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.filter(&String.length(&1) > 0)
    |> Stream.filter(&String.at(&1, 0) != "#")
    |> Stream.map(&String.split(&1, "=", trim: true))
    |> Enum.map(&extract(&1))
  end

  def get(config, property, default \\ nil) do
    # value = Enum.find(config, fn(%{ prop: p, val: _v} = _x) -> p == property end)
    # value = Enum.find(config, fn(x) -> x.prop == property end)
    case Enum.find(config, fn(x) -> x.prop == property end) do
      %{prop: _p, val: v} -> v
      nil -> default
    end
  end

  defp extract( [prop, val] = _x ) do
    %{ prop: String.trim(prop), val: String.trim(val)}
  end
end

c_data = Config.read_config()
IO.inspect c_data
data_dir = Config.get(c_data, "DataDir", "home/data")
IO.inspect data_dir
port = Config.get(c_data, "Port", 8000)
IO.inspect port
