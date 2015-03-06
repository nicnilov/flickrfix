class AlbumsController < ApplicationController
  def show
    @videos = flickrapi.list_album_videos(params[:id])
    @videos.sort_by
  end
end
