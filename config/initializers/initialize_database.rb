require 'digest'
require 'http'
require 'json'
## TODO
# PEGAR O TOTAL -> fazer o while bonitin

ts = '123456789012354'
public_key = "b091e4f619436453d9a951e666a18be8"
private_key = "41c8c6053be4b279e2d3c256fb3f782e1f9cc28b"
hash = Digest::MD5.hexdigest(ts+private_key+public_key)
total_characters_in_marvel_api = 0

uri = 'https://gateway.marvel.com:443/v1/public/characters?ts='+ts+'&apikey='+public_key+'&hash='+hash
response = HTTP.get(uri, :params => {:limit => "1"})

if JSON.parse(response)["code"] == 200
  total_characters_in_marvel_api = JSON.parse(response)["data"]["total"]
end

#if there is a new character there, database will update when server starts
if Character.count < total_characters_in_marvel_api
  offset = Character.count
  while(Character.count < total_characters_in_marvel_api) do
    uri = 'https://gateway.marvel.com:443/v1/public/characters?ts='+ts+'&apikey='+public_key+'&hash='+hash
    response = HTTP.get(uri, :params => {:offset => offset.to_s, :limit => "100"})
    data = JSON.parse(response)["data"]
    data["results"].each do |character|
        thumbnail = character["thumbnail"]
        thumb = thumbnail["path"] + '.' + thumbnail["extension"]
        new_character = Character.new(name: character["name"], description: character["description"], thumbnail: thumb, uuid: character["id"])
        if new_character.save
            puts "Saving "+new_character.name+" on database."
        else
            puts new_character.name+" already on databse."
        end
    end
    offset = offset + 100
  end
else
    puts "Character table is currently updated"
end
