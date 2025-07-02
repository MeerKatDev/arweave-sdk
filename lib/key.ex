defmodule Arweave.Key do
  def load_jwk(path) do
    jwk =
      path
      |> File.read!()
      |> Jason.decode!()

    # Decode base64url values
    decode = &Base.url_decode64!(&1, padding: false)

    %{
      n: decode.(jwk["n"]),
      e: decode.(jwk["e"]),
      d: decode.(jwk["d"]),
      p: decode.(jwk["p"]),
      q: decode.(jwk["q"]),
      dp: decode.(jwk["dp"]),
      dq: decode.(jwk["dq"]),
      qi: decode.(jwk["qi"])
    }
    |> to_private_key()
  end

  defp to_private_key(%{n: n, e: e, d: d, p: p, q: q, dp: dp, dq: dq, qi: qi}) do
    {:RSAPrivateKey, :"two-prime", n, e, d, p, q, dp, dq, qi, :asn1_NOVALUE}
  end
end
