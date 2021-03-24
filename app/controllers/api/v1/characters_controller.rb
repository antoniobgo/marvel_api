class Api::V1::CharactersController < ApplicationController
    def index
        characters = Character.all
        render json: characters
    end
    def show
      character = Character.find(params[:id])
      return render :not_found unless character
      render json: Character.find(params[:id])
    end
end
