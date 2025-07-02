defmodule Arweave.Hash do
  @moduledoc """
  Used by arweave to hash stuff
  """

  def deep_hash(data) when is_binary(data) do
    prefix = encode_length_prefixed("blob", data)
    :crypto.hash(:sha256, prefix)
  end

  def deep_hash(list) when is_list(list) do
    hashed_items = Enum.map(list, &deep_hash/1)
    prefix = encode_length_prefixed("list", IO.iodata_to_binary(hashed_items))
    :crypto.hash(:sha256, prefix)
  end

  defp encode_length_prefixed(label, data) do
    <<byte_size(label)::unsigned-big-integer-size(64)>> <>
      label <>
      <<byte_size(data)::unsigned-big-integer-size(64)>> <>
      data
  end
end
