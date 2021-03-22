class Api::V1::CharactersController < ApplicationController
    def index
        characters = Character.all
        render json: characters
    end
    def show
        render json: Character.find(params[:id])
    end
end
