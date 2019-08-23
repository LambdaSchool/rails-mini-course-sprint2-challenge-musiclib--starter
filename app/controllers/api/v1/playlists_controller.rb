module Api
  module V1
    class PlaylistsController < ApplicationController
      def index
        puts params, "PlaylistsController index"
        render json:{message: "index", params: params}
      end

      def create
        puts params, "PlaylistsController create"
        render json:{message: "create"}
      end

      def show
        puts params, "PlaylistsController show"
        render json:{message: "show"}
      end
    end
  end
end
