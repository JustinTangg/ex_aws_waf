defmodule ExAws.Wafv2 do
  @moduledoc """
  Documentation for `ExAws.Wafv2`.
  """

  import ExAws.Utils

  @version "2019-07-29"

  @type list_resources_for_web_acl_opts :: [
    resource_type: binary
  ]
  @spec list_resources_for_web_acl(web_acl_arn :: binary) :: ExAws.Operation.JSON.t()
  @spec list_resources_for_web_acl(web_acl_arn :: binary, opts :: list_resources_for_web_acl_opts) :: ExAws.Operation.JSON.t()
  def list_resources_for_web_acl(web_acl_arn, opts \\ []) do
    query_params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"WebACLArn": web_acl_arn})

    request(:list_resources_for_web_acl, query_params)
  end

  @type list_web_acls_opts :: [
    limit: integer,
    next_marker: binary
  ]
  @spec list_web_acls(scope :: binary) :: ExAws.Operation.JSON.t()
  @spec list_web_acls(scope :: binary, opts :: list_web_acls_opts) :: ExAws.Operation.JSON.t()
  def list_web_acls(scope, opts \\ []) do
    query_params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"Scope" => scope})

    request(:list_web_acls, query_params)
  end

  ####################
  # Helper Functions #
  ####################
  defp request(action, data) do
    operation = action |> Atom.to_string() |> Macro.camelize() |> String.replace("Acl", "ACL")

    ExAws.Operation.JSON.new(
      :wafv2,
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
