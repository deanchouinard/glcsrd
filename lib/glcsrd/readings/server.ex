defmodule Glcsrd.Readings.Server do
  use GenServer
  alias Glcsrd.Readings.Impl

  def start_link() do
    GenServer.start_link(__MODULE__, {}, name: GlcsrdData)
  end

  def init(state) do
    state = Impl.load()
    {:ok, state}
  end


  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

end

