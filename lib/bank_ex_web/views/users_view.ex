defmodule BankExWeb.UsersView do
  @moduledoc """
  The user view context.
  """
  use BankExWeb, :view

  alias BankEx.Services.Crypto

  @doc """
  Render the user response 
  """
  def render("user.json", %{user: %{referral_code: referral_code}}) do
    %{message: "User created successfully", referral_code: referral_code}
  end
  def render("users.json", %{users: users}) do
    users
    |> Enum.map(&Map.take(&1, ~w(id name)a))
    |> Enum.map(fn %{name: name} = user ->
      name = Crypto.decrypt(name)

      %{id: user.id, name: name}
    end)
  end
end
