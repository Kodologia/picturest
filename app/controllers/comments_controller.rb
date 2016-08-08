class CommentsController < ApplicationController
  before_action :login_required

  def create
    photo = Photo.find(params[:photo_id])
    comment = photo.comments.create!(
      body: params[:comment][:body],
      user: current_user
    )
    flash[:success] = 'Komentarz został dodany.'
    redirect_to photo
  end
end
