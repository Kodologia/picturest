class ProfilesController < ApplicationController
  before_action :login_required

  def account
  end

  def photos_collection
    @photos = current_user.saved_photos
  end
end
