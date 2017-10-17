defmodule ElMeduza.Meduza.Base do
  @moduledoc """
  Main module for fetching and parsing requestes based on HTTPoison and Poison
  """
  @base_url "https://meduza.io/api/v3/"

  def fetch_data(url) do
    url
    |> build_url
    |> HTTPoison.get
    |> parse_response
    |> decode
  end

  defp build_url(url), do: @base_url <> url

  defp parse_response({:ok, %HTTPoison.Response{headers: headers, body: body, status_code: 200}}) do
    case gzipped?(headers) do
      true -> {:ok, body |> unzip_body}
      false -> {:ok, body}
    end
  end
  defp parse_response(_), do: {:error, "Something went wrong!"}

  defp decode({:ok, body}) do
    body |> Poison.decode
  end
  defp decode({:error, error}), do: {:error, "Something went wrong!"}

  defp unzip_body(data), do: data |> :zlib.gunzip()

  defp gzipped?(res) do
    Enum.any?(res, fn({k, v}) -> {k, v} == {"Content-Encoding", "gzip"} end)
  end
end
