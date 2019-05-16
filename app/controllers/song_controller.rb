class SongController < ApplicationController
  def index
    songs = Song.all
    render :json => {'songs' => songs.map{ |song| song[:new_work_title]}}  
  end
end

