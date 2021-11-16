class Api::V1::CommentsController < Api::V1::GraphitiController
  def index
    comments = CommentResource.all(params)
    respond_with(comments)
  end

  def show
    comment = CommentResource.find(params)
    respond_with(comment)
  end

  def create
    comment = CommentResource.build(params)

    if comment.save
      render jsonapi: comment, status: 201
    else
      render jsonapi_errors: comment
    end
  end

  def update
    comment = CommentResource.find(params)

    if comment.update_attributes
      render jsonapi: comment
    else
      render jsonapi_errors: comment
    end
  end

  def destroy
    comment = CommentResource.find(params)

    if comment.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: comment
    end
  end
end
