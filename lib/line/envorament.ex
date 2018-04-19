defmodule Line.Environment do

  def channel_id do
    Application.fetch_env!(:line, :channel_id)
  end
  
  def channel_secret do
    Application.get_env(:line, :channel_secret, System.get_env("CHANNEL_SECRET"))
  end

  def redirect_uri do
    Application.fetch_env!(:line, :redirect_uri)
  end

end
