class Api::V1::FollowRequestsController < Api::V1::GraphitiController
  def index
    follow_requests = FollowRequestResource.all(params)
    respond_with(follow_requests)
  end

  def show
    follow_request = FollowRequestResource.find(params)
    respond_with(follow_request)
  end

  def create
    follow_request = FollowRequestResource.build(params)

    if follow_request.save
      render jsonapi: follow_request, status: :created
    else
      render jsonapi_errors: follow_request
    end
  end

  def update
    follow_request = FollowRequestResource.find(params)

    if follow_request.update_attributes
      render jsonapi: follow_request
    else
      render jsonapi_errors: follow_request
    end
  end

  def destroy
    follow_request = FollowRequestResource.find(params)

    if follow_request.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: follow_request
    end
  end
end
