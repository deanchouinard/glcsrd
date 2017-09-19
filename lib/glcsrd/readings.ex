defmodule Glcsrd.Readings do

  def get() do
  #    Glcsrd.Readings.Impl.load()
    {glucose, weight} = GenServer.call(GlcsrdData, :get)
  end

end

