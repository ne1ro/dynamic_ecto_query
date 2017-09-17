defmodule DynamicEctoQueryApp do
  @moduledoc """
  Main app supervisor
  """

  use Supervisor
  require Logger

  def start(_, _),
    do: Supervisor.start_link(__MODULE__, :ok, name: AppSupervisor)

  @spec init(:ok) :: {:ok, {:supervisor.sup_flags, [Supervisor.Spec.spec]}}
  def init(:ok) do
    _ = Logger.info("Start App supervisor")
    children = [worker(Repo, [])]

    supervise(children, strategy: :one_for_one)
  end
end
