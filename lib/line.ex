defmodule Line do
  alias Line.Environment
  @endpoint_auth "https://access.line.me/oauth2/v2.1/authorize"
  @endpoint_me "https://api.line.me"
  
  def login_url(state) do
    "#{@endpoint_auth}"
    <> "?response_type=code"
    <> "&client_id=#{Environment.channel_id()}"
    <> "&redirect_uri=#{Environment.redirect_uri()}"
    <> "&state=#{state}"
    <> "&scope=profile"
  end

  def access_token(code) do
    body = [
      grant_type: "authorization_code",
      code: code,
      redirect_uri: Environment.redirect_uri(),
      client_id: Environment.channel_id(),
      client_secret: Environment.channel_secret()
    ]
    headers = [{"Content-Type", "application/x-www-form-urlencoded"}]
    "#{@endpoint_me}/oauth2/v2.1/token"
    |> HTTPoison.post({:form, body}, headers)
    |> decode()
  end

  def profile(access_token) do
    headers = [{"Authorization", "Bearer #{access_token}"}]
    "#{@endpoint_me}/v2/profile"
    |> HTTPoison.get(headers)
    |> decode()
  end

  defp decode(response) do
    case response do
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
      {:ok, %HTTPoison.Response{body: body}} ->
        case Poison.decode!(body) do
          %{"error_description" => error_description} -> {:error, error_description}
          decoded_body -> {:ok, decoded_body}
        end
    end
  end

end
