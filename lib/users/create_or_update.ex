defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{cpf: cpf}) when not is_binary(cpf) do
    {:error, "Cpf must be a String"}
  end

  def call(%{cpf: cpf, email: email, name: name}) do
    User.build(name, email, cpf)
    |> handle_save_user()
  end

  def call(_), do: {:error, "Invalid Parameters"}

  defp handle_save_user({:ok, %User{id: id} = user}) do
    UserAgent.save(user)
    {:ok, id}
  end

  defp handle_save_user({:error, _} = error), do: error
end
