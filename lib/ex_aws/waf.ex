defmodule ExAws.Waf do
  @moduledoc """
  Documentation for `ExAws.Waf`.
  """

  import ExAws.Utils

  @version "2015-08-24"

  @spec get_web_acl(web_acl_id :: binary) :: ExAws.Operation.JSON.t()
  def get_web_acl(web_acl_id) do
    request(:get_web_acl, %{"WebACLId" => web_acl_id})
  end

  @type list_web_acls_opts :: [
    limit: integer,
    next_marker: binary,
    scope: binary
  ]
  @spec list_web_acls() :: ExAws.Operation.JSON.t()
  @spec list_web_acls(opts :: list_web_acls_opts) :: ExAws.Operation.JSON.t()
  def list_web_acls(opts \\ []) do
    query_params =
      opts
      |> normalize_opts()

    request(:list_web_acls, query_params)
  end

  ####################
  # Helper Functions #
  ####################
  defp request(action, data) do
    operation = action |> Atom.to_string() |> Macro.camelize() |> String.replace("Acl", "ACL")

    ExAws.Operation.JSON.new(
      :waf,
      %{
        data: data,
        headers: [
          {"x-amz-target", "AWSWAF_#{format_version()}.#{operation}"},
          {"content-type", "application/x-amz-json-1.1"}
        ]
      }
    )
  end

  defp format_version(), do: String.replace(@version, "-", "")

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys
  end
end
