defmodule BKashEx.Checkout.Credentials do
  @moduledoc """
  Stores all the credential information for checkout.
  """
  use GenServer
  alias __MODULE__

  @type authorization_header_type :: %{
          authorization: String.t(),
          x_app_key: String.t()
        }

  # ------------------------------------------
  # PUBLIC API
  # ------------------------------------------
  defp read_from_file() do
    with {:ok, body} <- File.read(Application.get_env(:bkash_ex, :bkash_env_file)),
         {:ok, json} <- Poison.decode(body),
         do: {:ok, json}
  end

  @doc """
  Read credential information, either from env or from `.bkash.env.json`
  """
  def read() do
    case credentials = Application.get_env(:bkash_ex, :checkout_credentials) do
      nil -> read_from_file()
      _ -> credentials
    end
  end

  @doc """
  Returns the entire data as Elixir map
  """
  def get_data(pid), do: GenServer.call(pid, {:get, :all})

  @doc """
  Returns username
  """
  def get_username(pid), do: GenServer.call(pid, {:get, :username})

  @doc """
  Returns password
  """
  def get_password(pid), do: GenServer.call(pid, {:get, :password})

  @doc """
  Returns app key
  """
  def get_app_key(pid), do: GenServer.call(pid, {:get, :app_key})

  @doc """
  Returns app secret
  """
  def get_app_secret(pid), do: GenServer.call(pid, {:get, :app_secret})

  @doc """
  Returns full URL
  """
  def get_base_url(pid), do: GenServer.call(pid, {:get, :base_url})

  @doc """
  Returns API version
  """
  def get_version(pid), do: GenServer.call(pid, {:get, :version})

  @doc """
  Returns username
  """
  def get_url(pid), do: GenServer.call(pid, {:get, :url})

  def start_link(opts) do
    GenServer.start_link(Credentials, :ok, opts)
  end

  # ------------------------------------------
  # SERVER API
  # ------------------------------------------
  @impl GenServer
  def init(_) do
    read()
  end

  @impl GenServer
  def handle_call({:get, attr}, _from, state) do
    checkout_state = state["checkout"]

    case attr do
      :all ->
        {:reply, checkout_state, state}

      :username ->
        {:reply, Map.get(checkout_state, "username"), state}

      :password ->
        {:reply, Map.get(checkout_state, "password"), state}

      :app_key ->
        {:reply, Map.get(checkout_state, "app_key"), state}

      :app_secret ->
        {:reply, Map.get(checkout_state, "app_secret"), state}

      :base_url ->
        {:reply, Map.get(checkout_state, "base_url"), state}

      :version ->
        {:reply, Map.get(checkout_state, "version"), state}

      :url ->
        {:reply,
         [Map.get(checkout_state, "base_url"), Map.get(checkout_state, "version")]
         |> Enum.join("/"), state}
    end
  end
end
