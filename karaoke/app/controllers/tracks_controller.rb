class TracksController < ApplicationController
  def new
  end

  def create
    render plain: params[:track].inspect
  end

  def index
   if params[:search]
      #@tracks = Track.search(params[:search]).order('artist')
      @tracks = Track.search(params[:search])
    else
      @tracks = Track.all.order('artist')
    end
  end

  def show
    @track = Track.find(params[:id])
    `/usr/bin/vlc --one-instance --playlist-enqueue "#{@track.path}" &`
  end
end
