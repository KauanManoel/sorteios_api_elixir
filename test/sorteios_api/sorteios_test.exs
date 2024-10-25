defmodule SorteiosApi.SorteiosTest do
  use SorteiosApi.DataCase

  alias SorteiosApi.Sorteios

  describe "raffles" do
    alias SorteiosApi.Sorteios.Raffle

    import SorteiosApi.SorteiosFixtures

    @invalid_attrs %{name: nil, date: nil}

    test "list_raffles/0 returns all raffles" do
      raffle = raffle_fixture()
      assert Sorteios.list_raffles() == [raffle]
    end

    test "get_raffle!/1 returns the raffle with given id" do
      raffle = raffle_fixture()
      assert Sorteios.get_raffle!(raffle.id) == raffle
    end

    test "create_raffle/1 with valid data creates a raffle" do
      valid_attrs = %{name: "some name", date: ~U[2024-10-23 17:28:00Z]}

      assert {:ok, %Raffle{} = raffle} = Sorteios.create_raffle(valid_attrs)
      assert raffle.name == "some name"
      assert raffle.date == ~U[2024-10-23 17:28:00Z]
    end

    test "create_raffle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sorteios.create_raffle(@invalid_attrs)
    end

    test "update_raffle/2 with valid data updates the raffle" do
      raffle = raffle_fixture()
      update_attrs = %{name: "some updated name", date: ~U[2024-10-24 17:28:00Z]}

      assert {:ok, %Raffle{} = raffle} = Sorteios.update_raffle(raffle, update_attrs)
      assert raffle.name == "some updated name"
      assert raffle.date == ~U[2024-10-24 17:28:00Z]
    end

    test "update_raffle/2 with invalid data returns error changeset" do
      raffle = raffle_fixture()
      assert {:error, %Ecto.Changeset{}} = Sorteios.update_raffle(raffle, @invalid_attrs)
      assert raffle == Sorteios.get_raffle!(raffle.id)
    end

    test "delete_raffle/1 deletes the raffle" do
      raffle = raffle_fixture()
      assert {:ok, %Raffle{}} = Sorteios.delete_raffle(raffle)
      assert_raise Ecto.NoResultsError, fn -> Sorteios.get_raffle!(raffle.id) end
    end

    test "change_raffle/1 returns a raffle changeset" do
      raffle = raffle_fixture()
      assert %Ecto.Changeset{} = Sorteios.change_raffle(raffle)
    end
  end
end
