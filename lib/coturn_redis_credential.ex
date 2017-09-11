defmodule CoturnRedisCredential do

  @moduledoc """
  This module provides a function to generate credentials which you need to
  use coturn with authentication through Redis.
  """

  @default_username_length 40

  def gen_random(realm, secret, timeout, username_length \\ @default_username_length) do
    name = SecureRandom.hex(username_length)
    exp = System.system_time(:seconds) + timeout
    gen(realm, secret, name, exp)
  end

  def gen(realm, secret, name, exp) do
    username = gen_username(name, exp)
    password = gen_password(username, secret)
    key = gen_redis_key(realm, username)
    value = gen_redis_value(realm, username, password)
    {:ok, username, password, key, value}
  end

  @spec gen_username(String.t, String.t) :: String.t
  def gen_username(name, exp) do
    "#{exp}:#{name}"
  end

  @spec gen_password(String.t, String.t) :: String.t
  def gen_password(username, secret) do
    :crypto.hmac(:sha, secret, username)
    |> Base.encode64(case: :lower)
  end

  @spec gen_redis_key(String.t, String.t) :: String.t
  def gen_redis_key(realm, username) do
    "turn/realm/#{realm}/user/#{username}/key"
  end

  @spec gen_redis_value(String.t, String.t, String.t) :: String.t
  def gen_redis_value(realm, username, password) do
    "#{username}:#{realm}:#{password}"
    |> :erlang.md5
    |> Base.encode16(case: :lower)
  end
end
