defmodule SorteiosApiWeb.RaffleControllerTest do
  use SorteiosApiWeb.ConnCase

  import SorteiosApi.SorteiosFixtures

  alias SorteiosApi.Sorteios.Raffle

  @create_attrs %{
    name: "some name",
    date: ~U[2024-10-23 17:28:00Z]
  }
  @update_attrs %{
    name: "some updated name",
    date: ~U[2024-10-24 17:28:00Z]
  }
  @invalid_attrs %{name: nil, date: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all raffles", %{conn: conn} do
      conn = get(conn, ~p"/api/raffles")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create raffle" do
    test "renders raffle when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/raffles", raffle: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/raffles/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-10-23T17:28:00Z",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/raffles", raffle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update raffle" do
    setup [:create_raffle]

    test "renders raffle when data is valid", %{conn: conn, raffle: %Raffle{id: id} = raffle} do
      conn = put(conn, ~p"/api/raffles/#{raffle}", raffle: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/raffles/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-10-24T17:28:00Z",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, raffle: raffle} do
      conn = put(conn, ~p"/api/raffles/#{raffle}", raffle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete raffle" do
    setup [:create_raffle]

    test "deletes chosen raffle", %{conn: conn, raffle: raffle} do
      conn = delete(conn, ~p"/api/raffles/#{raffle}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/raffles/#{raffle}")
      end
    end
  end

  defp create_raffle(_) do
    raffle = raffle_fixture()
    %{raffle: raffle}
  end
end
