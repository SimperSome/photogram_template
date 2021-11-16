class FollowRequestsController < ApplicationController
  before_action :current_user_must_be_follow_request_sender,
                only: %i[edit update destroy]

  before_action :set_follow_request, only: %i[show edit update destroy]

  def index
    @q = current_user.sent_follow_requests.ransack(params[:q])
    @follow_requests = @q.result(distinct: true).includes(:sender,
                                                          :recipient).page(params[:page]).per(10)
  end

  def show; end

  def new
    @follow_request = FollowRequest.new
  end

  def edit; end

  def create
    @follow_request = FollowRequest.new(follow_request_params)

    if @follow_request.save
      message = "FollowRequest was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @follow_request, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @follow_request.update(follow_request_params)
      redirect_to @follow_request,
                  notice: "Follow request was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @follow_request.destroy
    message = "FollowRequest was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to follow_requests_url, notice: message
    end
  end

  private

  def current_user_must_be_follow_request_sender
    set_follow_request
    unless current_user == @follow_request.sender
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  def set_follow_request
    @follow_request = FollowRequest.find(params[:id])
  end

  def follow_request_params
    params.require(:follow_request).permit(:sender_id, :recipient_id)
  end
end
