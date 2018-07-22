defmodule BKashEx do
  @moduledoc """
  Documentation for BKasheEx.
  """
  use Application

  def start(_type, _args) do
    children = [
      {BKashEx.Checkout.Credentials, name: :checkout_credentials},
      Plug.Adapters.Cowboy2.child_spec(
        scheme: :http,
        plug: BKashEx.Web.Router,
        options: [port: 4001]
      )
    ]

    opts = [strategy: :one_for_one, name: BKashEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
