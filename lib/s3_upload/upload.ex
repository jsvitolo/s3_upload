defmodule S3Upload.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  alias S3Upload.Upload

  schema "uploads" do
    field :image_url, :string

    timestamps()
  end

    def changeset(%Upload{} = upload, params \\ :invalid) do
      upload
      |> cast(params, [:image_url])
      |> validate_required([:image_url])
    end
end