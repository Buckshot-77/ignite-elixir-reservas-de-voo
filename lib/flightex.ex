defmodule Flightex do
  alias Flightex.Users.Agent, as: UserAgent

  def start_agents do
    UserAgent.start_link(%{})
  end

  # defdelegate , to:
  # defdelegate , to:
end
