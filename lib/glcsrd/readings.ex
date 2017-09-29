defmodule Glcsrd.Readings do

  def get() do
  #    Glcsrd.Readings.Impl.load()
    %{glucose: glucose, weight: weight} = GenServer.call(GlcsrdData, :get)
    {glucose, weight}
  end

  def reload() do
    %{glucose: glucose, weight: weight} = GenServer.call(GlcsrdData, :reload)
    {glucose, weight}
  end
end

