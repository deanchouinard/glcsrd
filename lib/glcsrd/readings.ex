defmodule Glcsrd.Readings do

  def get() do
    Glcsrd.Readings.Impl.load()
  end

end

