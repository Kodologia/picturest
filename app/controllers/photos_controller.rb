class PhotosController < ApplicationController
  before_action :login_required, except: [:index, :show]
  before_action :set_photo, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.page(params[:page])
  end

  def show
    @photo = Photo.find(params[:id])
    @rating = @photo.ratings.find_by(user: current_user)
    @comment = Comment.new
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

  def rate
    photo = Photo.find(params[:id])
    rating = photo.ratings.find_or_initialize_by(user: current_user)
    rating.value = params[:value]
    rating.save!
    flash[:success] = 'Ocena została zapisana.'
    redirect_to(:back)
  end

  def save_to_user_collection
    photo = Photo.find(params[:id])
    current_user.saved_photos << photo
    flash[:success] = 'Obrazek został dodany zapisany do Twojej kolekcji.'
    redirect_to(:back)
  end

private
  def set_photo
    @photo = current_user.photos.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end
end
