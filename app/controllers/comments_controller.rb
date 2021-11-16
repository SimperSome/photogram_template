class CommentsController < ApplicationController
  before_action :current_user_must_be_comment_commenter,
                only: %i[edit update destroy]

  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @q = current_user.comments.ransack(params[:q])
    @comments = @q.result(distinct: true).includes(:commenter,
                                                   :photo).page(params[:page]).per(10)
  end

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      message = "Comment was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @comment, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    message = "Comment was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to comments_url, notice: message
    end
  end

  private

  def current_user_must_be_comment_commenter
    set_comment
    unless current_user == @comment.commenter
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :commenter_id, :photo_id)
  end
end
