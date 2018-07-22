defmodule BKashEx.Checkout.Credentials do
  defp read_from_file() do
    with {:ok, body} <- File.read(Application.get_env(:bkash_ex, :bkash_env_file)),
         {:ok, json} <- Poison.decode(body),
         do: {:ok, json}
  end

  def read() do
    case credentials = Application.get_env(:bkash_ex, :checkout_credentials) do
      nil -> read_from_file()
      _ -> credentials
    end
  end
end
