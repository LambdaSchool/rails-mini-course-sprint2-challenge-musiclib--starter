module Api
  module V1
    class SongsController < ApplicationController
      def index
        @songs = if params[:album_id].present?
                   Album.find(params[:album_id]).songs
                 elsif params[:playlist_id].present?
                   Playlist.find(params[:playlist_id]).songs
                 else
                   Song.all
                 end

        @sorted_songs = SongSorter.new(@songs, params[:sort]).sort
        render json: @sorted_songs
      end

      def show
        @song = Song.find(params[:id])
        render json: @song
      end

      def create
        @playlist = Playlist.find(params[:playlist_id])
        @playlist_song = @playlist.playlist_songs.build(playlist_song_params)

        if @playlist_song.save
          render json: @playlist, status: :created, location: api_v1_playlist_url(@playlist)
        else
          render json: @playlist_song.errors, status: :unprocessable_entity
        end
      end

      private

      def playlist_song_params
        params.require(:song).permit(:song_id)
      end
    end
  end
end
