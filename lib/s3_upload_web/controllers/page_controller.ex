defmodule S3UploadWeb.PageController do
  use S3UploadWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
