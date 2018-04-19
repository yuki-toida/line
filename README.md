# LINE
simple HTTP client for [LINE Login](https://developers.line.me/ja/docs/line-login/overview/).

## Installation
```elixir
def deps do
  [
    {:line, "~> 0.1.0"}
  ]
end
```

## Configuration
```elixir
use Mix.Config

config :line,
  channel_id: 999999999,
  channel_secret: "YOUR CHANNEL SECRET"
  redirect_uri: "YOUR REDIRECT URI"
```

channel_secret: you can use environment variables.

```bash
export CHANNEL_SECRET="YOUR CHANNEL SECRET"
```

## License
MIT