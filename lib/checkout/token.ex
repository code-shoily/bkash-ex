defmodule BKashEx.Checkout.Authorization do
  alias __MODULE__
  alias BKashEx.Utils.HTTP

  @type t() :: %{
          expires_in: String.t(),
          id_token: String.t(),
          refresh_token: String.t(),
          token_type: String.t()
        }

  @type grant_token_req :: %{
          app_key: String.t(),
          app_secret: String.t()
        }
  @suffix "/checkout/token/grant"
  @spec grant_token(grant_token_req, any()) :: {:error, any()} | {:ok, Authorization.t()}
  def grant_token(params, headers) do
    HTTP.pull(:checkout, @suffix, params, headers)
  end

  @type refresh_token_req :: %{
          app_key: String.t(),
          app_secret: String.t(),
          refresh_token: String.t()
        }
  @suffix "/checkout/token/refresh"
  @spec refresh_token(refresh_token_req, any()) :: {:error, any()} | {:ok, Authorization.t()}
  def refresh_token(params, headers) do
    HTTP.pull(:checkout, @suffix, params, headers)
  end
end
