module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        @playlist = Playlist.all

        render json: @playlist
      end
    
      def create
        @playlist = Playlist.new({name: params['name'], user_id: params['user_id'] })
        if @playlist.save
          render json: @playlist, status: :created, location: api_v1_user_playlists_url(@playlist)
        else
          render json: @playlist.errors, status: :unprocessable_entity
        end
      end

      def show
        @playlist = Playlist.find(params[:id])

        render json: @playlist
      end
    end
  end
end
