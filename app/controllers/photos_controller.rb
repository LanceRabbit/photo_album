class PhotosController < ApplicationController
  before_action :set_photo, :only => [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all
  end
  def new 
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      # 重新導向 index 頁面 
      redirect_to photos_url
    else
      # 仍然停留在當前action裡
      render  :action => :new
    end

  end
  
  def show
    set_photo
  end

  def edit
    set_photo
  end

  def update
    set_photo
    @photo.update_attributes(photo_params)
    if @photo.update_attributes(photo_params)
      # 回到特定照片的頁面
      redirect_to photo_path(@photo)
    else
      # 仍然停留在當前action裡
      render  :action => :edit
    end

  end

  def destroy
    set_photo
    @photo.destroy

    redirect_to photos_url
  end
  private

  def set_photo
    @photo = Photo.find(params[:id])
  end
  def photo_params
    params.require(:photo).permit(:title, :date, :description, :file_location)
  end

end
