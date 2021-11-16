class PhotosController < ApplicationController
  before_action :current_user_must_be_photo_owner,
                only: %i[edit update destroy]

  before_action :set_photo, only: %i[show edit update destroy]

  # GET /photos
  def index
    @q = Photo.ransack(params[:q])
    @photos = @q.result(distinct: true).includes(:owner, :likes, :comments,
                                                 :fan_followers, :followers, :fans).page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@photos.where.not(location_latitude: nil)) do |photo, marker|
      marker.lat photo.location_latitude
      marker.lng photo.location_longitude
      marker.infowindow "<h5><a href='/photos/#{photo.id}'>#{photo.caption}</a></h5><small>#{photo.location_formatted_address}</small>"
    end
  end

  # GET /photos/1
  def show
    @comment = Comment.new
    @like = Like.new
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit; end

  # POST /photos
  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      message = "Photo was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @photo, notice: message
      end
    else
      render :new
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: "Photo was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
    message = "Photo was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to photos_url, notice: message
    end
  end

  private

  def current_user_must_be_photo_owner
    set_photo
    unless current_user == @photo.owner
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_photo
    @photo = Photo.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def photo_params
    params.require(:photo).permit(:caption, :image, :owner_id, :location)
  end
end
