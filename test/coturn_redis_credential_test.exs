defmodule CoturnRedisCredentialTest do
  use ExUnit.Case
  doctest CoturnRedisCredential

  test "gen_random" do

    realm = "example.org"
    secret = "hogehoge"
    timeout = 60

    {:ok, username, _password, _key, _value} = CoturnRedisCredential.gen_random(realm, secret, timeout)
    assert Regex.match?(~r/^\d+\:[0-9a-fA-F]{80}+$/, username)
  end

  test "gen_random with length" do

    realm = "example.org"
    secret = "hogehoge"
    timeout = 60

    {:ok, username, _password, _key, _value} = CoturnRedisCredential.gen_random(realm, secret, timeout, 20)
    assert Regex.match?(~r/^\d+\:[0-9a-fA-F]{40}$/, username)
  end

  test "gen" do

    realm = "example.org"
    secret = "hogehoge"
    name = "68f6dbdfaf938ddce362cb3cf31a2632d4fd3970"
    seconds = 1505132829

    {:ok, username, password, key, value} = CoturnRedisCredential.gen(realm, secret, name, seconds)
    assert username == "1505132829:68f6dbdfaf938ddce362cb3cf31a2632d4fd3970"
    assert password == "RV8jNRLQnSdnMHZbtTg2QqznYrA="
    assert key == "turn/realm/example.org/user/1505132829:68f6dbdfaf938ddce362cb3cf31a2632d4fd3970/key"
    assert value == "90df2a56627881bf2787d9398cad75a8"
  end
end
