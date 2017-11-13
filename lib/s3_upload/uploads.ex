defmodule S3Upload.Uploads do
  import Ecto.Query, warn: false

  alias S3Upload.Repo
  alias S3Upload.Uploads
  alias S3Upload.Upload

  def change_upload(%Upload{} = upload) do
    Upload.changeset(upload, %{})
  end

  def create_upload(attrs \\ %{}) do
    require IEx; IEx.pry
    %Upload{}
    |> Upload.changeset(attrs)
    |> Repo.insert
  end
end