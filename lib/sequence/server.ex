defmodule Sequence.Server do
  use GenServer

  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number() do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(__MODULE__, {:increment_number, delta})
  end

  def current_number() do
    GenServer.call(__MODULE__, :current_number)
  end

  def set_number(new_number) do
    GenServer.cast(__MODULE__, {:set_number, new_number})
  end

  ### Initializes the GenServer with some state
  def init(initial_number) do
    {:ok, initial_number}
  end

  ### handle_call returns a value to the caller
  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_call(:current_number, _from, current_number) do
    {:reply, current_number, current_number}
  end

  def handle_cast({:set_number, new_number}, _current_number) do
    {:noreply, new_number}
  end

  ### handle_cast does not return a value to the caller
  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end
end
