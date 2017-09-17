defmodule FilterQuery do
  @moduledoc """
  Query that accepts inclusion or exclusion parameters and filters by this parameters
  """

  import Ecto.Query

  defmacro __using__(attributes: allowed_attributes) do
    quote do
      import FilterQuery

      @spec filter(Ecto.Query.t, map, map) :: Ecto.Query.t
      def filter(query, inclusion, exclusion) do
        [inclusion, exclusion] = [sanitize(inclusion), sanitize(exclusion)]

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

      defp sanitize(keyword_list),
        do: for {key, val} <- keyword_list, allowed_key?(key), do: {key, val}

      defp allowed_key?(key), do: key in unquote(allowed_attributes)

      defp present?(list) when is_list(list), do: length(list) > 0
      defp present?(_), do: false
    end
  end
end
