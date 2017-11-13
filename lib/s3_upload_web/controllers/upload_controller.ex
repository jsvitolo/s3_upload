defmodule S3UploadWeb.UploadController do
  use S3UploadWeb, :controller

  alias S3Upload.Uploads
  alias S3Upload.Upload
  alias ExAws.S3

  def new(conn, _params) do
    changeset = Uploads.change_upload(%Upload{})

    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"upload" => %{"image" => image_params}} = upload_params) do
    file_uuid = UUID.uuid4(:hex)
    image_filename = image_params.filename
    unique_filename = "#{file_uuid}-#{image_filename}"
    {:ok, image_binary} = File.read(image_params.path)
    bucket_name = System.get_env("BUCKET_NAME")

    image =
      S3.put_object(bucket_name, unique_filename, image_binary)          
      |> ExAws.request!

    updated_params = 
      upload_params
      |> Map.update(image, image_params, fn _value ->
        "https://#{bucket_name}.s3:.amazonaws.com/#{unique_filename}"
      end)

    changeset = Upload.changeset(%Upload{}, updated_params)

    case Uploads.create_upload(changeset) do
      {:ok, upload} ->
        conn
        |> put_flash(:info, "Image uploaded successfully!")
        |> redirect(to: upload_path(conn, :new, upload))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
