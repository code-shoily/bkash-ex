defmodule BKashEx.Utils.Convert do
  @doc """
  Converts the keys of a map from string to atom.

  ## Example
    iex> str_to_atom_keys(%{"x" => 10, "y" => 20})
    %{x: 10, y: 20}
    iex> str_to_atom_keys(%{"x" => 10, :y => 20})
    %{x: 10, y: 20}
  """
  @spec str_to_atom_keys(map() | list()) :: map() | list()
  def str_to_atom_keys(m) when is_map(m) do
    m
    |> Map.new(fn
      {k, v} when is_binary(k) -> {String.to_atom(k), v}
      otherwise -> otherwise
    end)
  end

  def str_to_atom_keys(xs) when is_list(xs) do
    xs
    |> Enum.map(&str_to_atom_keys(&1))
  end
end
