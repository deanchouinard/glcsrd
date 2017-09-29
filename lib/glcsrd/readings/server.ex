defmodule Glcsrd.Readings.Server do
  use GenServer
  alias Glcsrd.Readings.Impl

  def start_link(dir) do
    GenServer.start_link(__MODULE__, dir, name: GlcsrdData)
  end

  def init(dir) do
    state = Impl.load(dir)
    {:ok, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state.readings, state}
  end

  def handle_call(:reload, _from, state) do
    state = Impl.load(state.dir)
    {:reply, state.readings, state}
  end
end

