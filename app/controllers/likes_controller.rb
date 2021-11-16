class LikesController < ApplicationController
  before_action :current_user_must_be_like_user,
                only: %i[edit update destroy]

  before_action :set_like, only: %i[show edit update destroy]

  def index
    @q = current_user.likes.ransack(params[:q])
    @likes = @q.result(distinct: true).includes(:user,
                                                :photo).page(params[:page]).per(10)
  end

  def show; end

  def new
    @like = Like.new
  end

  def edit; end

  def create
    @like = Like.new(like_params)

    if @like.save
      message = "Like was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @like, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @like.update(like_params)
      redirect_to @like, notice: "Like was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @like.destroy
    message = "Like was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to likes_url, notice: message
    end
  end

  private

  def current_user_must_be_like_user
    set_like
    unless current_user == @like.user
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:user_id, :photo_id)
  end
end
