defmodule SorteiosApi.Raffles do
  @moduledoc """
  Módulo para gerenciar sorteios.
  """

  # Estrutura para armazenar informações do sorteio
  defstruct id: nil, participantes: [], resultado: nil

  @raffles %{}

  # Função para criar um novo sorteio
  def create_raffle(id) do
    raffle = %__MODULE__{id: id}
    new_raffles = Map.put(@raffles, id, raffle)
    :ok = update_raffles(new_raffles)
    {:ok, raffle}
  end

  # Função para participar de um sorteio
  def participate_in_raffle(raffle_id, participante) do
    case Map.get(@raffles, raffle_id) do
      nil -> {:error, "Sorteio não encontrado"}
      raffle ->
        updated_raffle = %{raffle | participantes: [participante | raffle.participantes]}
        new_raffles = Map.put(@raffles, raffle_id, updated_raffle)
        :ok = update_raffles(new_raffles)
        {:ok, updated_raffle}
    end
  end

  # Função para obter o resultado do sorteio
  def get_raffle_result(raffle_id) do
    case Map.get(@raffles, raffle_id) do
      nil -> {:error, "Sorteio não encontrado"}
      raffle -> 
        if raffle.resultado do
          {:ok, raffle.resultado}
        else
          {:error, "Resultado ainda não disponível"}
        end
    end
  end

  # Função auxiliar para atualizar a estrutura de sorteios (mock)
  defp update_raffles(_new_raffles) do
    # Aqui você pode implementar a lógica para armazenar os sorteios,
    # como persistir em um banco de dados ou outra forma de armazenamento.
    :ok
  end
end
