defmodule BKashEx.Web.Schema do
  use Absinthe.Schema

  query do
    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "WORLD"} end)
    end
  end
end
