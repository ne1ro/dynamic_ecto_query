{:ok, _} = Application.ensure_all_started(:ex_machina)

defmodule Example do
  @moduledoc """
  Example of using dynamic ecto queries
  """

  import Factory
  use FilterQuery, attributes: ~w(proficiency name)a

  def run do
    insert_users()

    IO.inspect(count([]))
    [relationships_status: ["married"]] |> count([]) |> IO.inspect
    [proficiency: ["developer"]] |> count([]) |> IO.inspect
    [proficiency: ["soldier"]] |> count([]) |> IO.inspect
    IO.inspect(count([], %{proficiency: ["politic"]}))
  end

  defp insert_users do
    Repo.delete_all(User)

    insert(:user, relationships_status: "single", proficiency: "developer")
    insert(:user, relationships_status: "married", proficiency: "politic")
    insert(:user, relationships_status: "dating", proficiency: "thief")
  end

  defp count(inclusion, exclusion \\ []) do
    User
    |> filter(inclusion, exclusion)
    |> Repo.aggregate(:count, :id)
  end
end
