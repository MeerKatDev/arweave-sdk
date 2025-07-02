defmodule Arweave.Signer do
  def sign(data, private_key) do
    :crypto.sign(:rsa, :sha256, data, [
      private_key,
      {:rsa_pss_padding, saltlen: 32, mgf1_md: :sha256}
    ])
  end
end