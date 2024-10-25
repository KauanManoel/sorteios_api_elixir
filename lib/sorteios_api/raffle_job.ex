defmodule SorteiosApi.RaffleJob do
  use Oban.Worker, queue: :raffle
  alias SorteiosApi.VariacoesRaffle

  @impl Oban.Worker
  def perform(%{args: %{"raffle_id" => raffle_id}}) do
    with {:ok, raffle} <- VariacoesRaffle.get_raffle(raffle_id),
         true <- raffle.ended? do
      case select_winner(raffle_id) do
        {:ok, winner_id} ->
          VariacoesRaffle.update_raffle_with_winner(raffle_id, winner_id)

        {:error, _reason} ->
          :ok
      end
    else
      _ -> :ok  
    end
  end

  defp select_winner(raffle_id) do
    case VariacoesRaffle.get_participants_for_raffle(raffle_id) do
      [] -> {:error, "Nenhum participante encontrado para o sorteio."}
      participants -> {:ok, Enum.random(participants).user_id}  # Retorna o ID do usuário que ganhou
    end
  end
end
