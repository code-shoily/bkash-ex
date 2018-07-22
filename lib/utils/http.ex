defmodule BKashEx.Utils.HTTP do
  @moduledoc """
  Functions to pull data from the bKash API.
  """
  alias HTTPoison.Response
  alias BKashEx.Checkout.Credentials
  import BKashEx.Utils.Convert, only: [str_to_atom_keys: 1]

  @common_headers [{"Content-Type", "application/json"}]

  @doc """
  Pulls data from bKash endpoints. :checkout and :direct fetches data for
  Checkout and Direct.
  """
  @spec pull(:checkout | :direct, String.t(), map(), list(tuple())) ::
          {:ok, any()} | {:error, any()}
  def pull(:checkout, suffix, params, headers) do
    with {:ok, %Response{body: result}} <-
           HTTPoison.post(
             Credentials.get_url(:checkout_credentials) <> suffix,
             params,
             headers ++ @common_headers
           ),
         {:ok, decoded} <- Poison.decode(result) do
      {:ok, decoded |> str_to_atom_keys()}
    else
      {:error, error} -> {:error, error}
    end
  end
end
