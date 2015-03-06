class AlbumsController < ApplicationController

  before_filter :flickr_account_present?

  def show
    @videos = flickrapi.list_album_videos(params[:id])
    @videos.sort_by
  end

  private

  def flickr_account_present?
    redirect_to home_path unless current_flickr_account.present?
  end

end
