class Api::V1::ComicsController < ApplicationController
  def index
    @character = Character.find(params[:character_id])
    @total_comics = get_total_comics
    comics = get_comics(params[:pageNumber].to_i)
    render json: { comics: comics.as_json, total: @total_comics }
  end

  private

  def get_total_comics
    ts = '123456789012354'
    public_key = "b091e4f619436453d9a951e666a18be8"
    private_key = "41c8c6053be4b279e2d3c256fb3f782e1f9cc28b"
    params_concat = ts+private_key+public_key
    hashed_params = Digest::MD5.hexdigest(params_concat)
    uri = 'https://gateway.marvel.com:443/v1/public/characters/'+@character.uuid.to_s+'/comics?ts='+ts+'&apikey='+public_key+'&hash='+hashed_params
    response = HTTP.get(uri)
    if JSON.parse(response)["code"] == 200
      JSON.parse(response)["data"]["total"]
    end
  end

  def get_comics(page_number)
    ts = '123456789012354'
    public_key = "b091e4f619436453d9a951e666a18be8"
    private_key = "41c8c6053be4b279e2d3c256fb3f782e1f9cc28b"
    params_concat = ts+private_key+public_key
    hashed_params = Digest::MD5.hexdigest(params_concat)
    uri = 'https://gateway.marvel.com:443/v1/public/characters/'+@character.uuid.to_s+'/comics?ts='+ts+'&apikey='+public_key+'&hash='+hashed_params
    offset = 20 * (page_number - 1)
    if @character.comics.count < (20*page_number) && @total_comics > @character.comics.count
      response = HTTP.get(uri, :params => {:offset => offset.to_s, :limit => "20"})
      if JSON.parse(response)["code"] == 200
        data = JSON.parse(response)["data"]
        data["results"].each do |comic|
            thumbnail = comic["thumbnail"]
            thumb = thumbnail["path"] + '.' + thumbnail["extension"]
            new_comic = Comic.new(title: comic["title"], description: comic["description"],
              variantDescription: comic["variantDescription"], pageCount: comic["pageCount"],
              cover: thumb)
            new_comic.characters << @character
            if new_comic.save
                puts "Saving "+new_comic.title+" on database."
            else
                puts new_comic&.title+" already on database."
            end
        end
      end
      return @character.comics[offset..offset+19]
    else
      return @character.comics[offset..offset+19]
    end
  end
end
