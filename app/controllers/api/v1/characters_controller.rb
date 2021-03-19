class Api::V1::CharactersController < ApplicationController
    def show
        render json: Character.find(params[:id])
    end
end
