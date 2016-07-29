class PhotosController < ApplicationController
  before_action :login_required, except: [:index, :show]
  before_action :set_photo, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.all
  end

  def show
    Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    if @photo.save
      flash[:success] = 'Utworzono nowe zdjęcie.'
      redirect_to @photo
    else
      flash.now[:danger] = 'Nie można utworzyć zdjęcia.'
      render :new
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      flash[:success] = 'Zaktualizowano zdjęcie.'
      redirect_to @photo
    else
      flash.now[:danger] = 'Nie można zaktualizować zdjęcia.'
      render :edit
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = 'Zdjęcie zostało usunięte.'
    redirect_to photos_url
  end

private
  def set_photo
    @photo = current_user.photos.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end
end
