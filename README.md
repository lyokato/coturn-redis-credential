# CoturnRedisCredential

https://github.com/coturn/coturn/wiki/turnserver

## Usage

```elixir

  realm   = "example.org"
  secret  = "ab10d2d9be8e8cdedfab3e66cfaa9906bdbb0a01"
  timeout = 60 * 60 * 1

  {:ok, username, password, key, value} = CoturnRedisCredential.gen_random(realm, secret, timeout)

  Redix.command(conn, [SETEX", key, timeout, value])

  conn
  |> put_resp_content_type("application/json")
  |> send_resp(200, Poison.encode!(%{username: username, password: password})

```
