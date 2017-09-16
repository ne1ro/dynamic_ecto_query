defmodule FilterQuery do
  @moduledoc """
  Query that accepts filters for inclusion or exclusion and filters by this parameters
  """

  import Ecto.Query

  @spec filter(Ecto.Query.t, map) :: Ecto.Query.t
  def filter(query, %{inclusion: inclusion, exclusion: exclusion}) do
    queries = dynamic_query(:inclusion, inclusion) ++ dynamic_query(:exclusion, exclusion)
    Enum.reduce(queries, query, fn(q, acc) -> where(acc, ^q) end)
  end

  def filter(query, _) do
    query
  end

  defp dynamic_query(type, filters) when type in [:inclusion, :exclusion] do
    for {attr, values} <- filters, present?(values),
      do: dynamic_query(type, attr, values)
  end

  defp dynamic_query(:exclusion, exclusion) do
    for {attr, values} <- exclusion, do: dynamic_query(:exclusion, attr, values)
  end

  defp dynamic_query(:inclusion, attr, values) do
    dynamic([q], field(q, ^attr) in ^values)
  end

  defp dynamic_query(_, attr, values) do
    dynamic([q], field(q, ^attr) not in ^values)
  end

  defp present?(list) when is_list(list), do: length(list) > 0
  defp present?(_), do: false
end
