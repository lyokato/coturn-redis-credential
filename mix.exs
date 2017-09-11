defmodule CoturnRedisCredential.Mixfile do
  use Mix.Project

  def project do
    [app: :coturn_redis_credential,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :secure_random]]
  end

  defp deps do
    [
     {:secure_random, "~> 0.5"}
    ]
  end
end
