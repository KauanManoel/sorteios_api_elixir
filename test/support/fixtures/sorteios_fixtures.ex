defmodule SorteiosApi.SorteiosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SorteiosApi.Sorteios` context.
  """

  @doc """
  Generate a raffle.
  """
  def raffle_fixture(attrs \\ %{}) do
    {:ok, raffle} =
      attrs
      |> Enum.into(%{
        date: ~U[2024-10-23 17:28:00Z],
        name: "some name"
      })
      |> SorteiosApi.Sorteios.create_raffle()

    raffle
  end
end
