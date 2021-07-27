class SongsController < ApplicationController
  def index
    if params[:artist_id]
      #params[:author_id] coming from? Rails provides it for us through the nested route,
      #The conditional hinges on whether there's an :author_id key in the params hash — in other words, whether the user navigated to /authors/:id/posts 
      @song = Artist.find(params[:artist_id]).songs
      #accccounts for the new nest urls, so see if the user is tryting to access all pots or all post form a particular author
      if !@song
        redirect_to artists_path
      end
    else
      @songs = Song.all
    
    end
  end

  def show
    @song = Song.find(params[:id])
    if @song
    else
      redirect_to artist_songs_path(params[:artist_id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

