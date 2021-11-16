class Api::V1::LikesController < Api::V1::GraphitiController
  def index
    likes = LikeResource.all(params)
    respond_with(likes)
  end

  def show
    like = LikeResource.find(params)
    respond_with(like)
  end

  def create
    like = LikeResource.build(params)

    if like.save
      render jsonapi: like, status: :created
    else
      render jsonapi_errors: like
    end
  end

  def update
    like = LikeResource.find(params)

    if like.update_attributes
      render jsonapi: like
    else
      render jsonapi_errors: like
    end
  end

  def destroy
    like = LikeResource.find(params)

    if like.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: like
    end
  end
end
