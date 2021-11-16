class Api::V1::PhotosController < Api::V1::GraphitiController
  def index
    photos = PhotoResource.all(params)
    respond_with(photos)
  end

  def show
    photo = PhotoResource.find(params)
    respond_with(photo)
  end

  def create
    photo = PhotoResource.build(params)

    if photo.save
      render jsonapi: photo, status: :created
    else
      render jsonapi_errors: photo
    end
  end

  def update
    photo = PhotoResource.find(params)

    if photo.update_attributes
      render jsonapi: photo
    else
      render jsonapi_errors: photo
    end
  end

  def destroy
    photo = PhotoResource.find(params)

    if photo.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: photo
    end
  end
end
