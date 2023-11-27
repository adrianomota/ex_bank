defmodule ExBank.Infrastructure.Ports.ZipCodeProviderBehavior do
  @moduledoc """
  Interface for validate zip code service provider
  """
  @adapter Application.compile_env(:ex_bank, [__MODULE__, :adapter])

  @callback call(url :: String.t(), zip_code :: String.t()) :: {:ok, map()} | {:error, :atom}

  @spec call(url :: String.t(), zip_code :: String.t()) :: {:ok, map()} | {:error, :atom}
  defdelegate call(utl, zip_code), to: @adapter
end
