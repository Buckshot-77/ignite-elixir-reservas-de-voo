defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking

  use Agent

  def start_link(_inital_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{id: id} = booking) do
    Agent.update(__MODULE__, &update_state(&1, booking, id))
    {:ok, id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end

  defp update_state(state, %Booking{} = booking, id), do: Map.put(state, id, booking)
end