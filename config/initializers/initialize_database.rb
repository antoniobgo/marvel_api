require 'digest'
require 'http'
require 'json'
## TODO
# PEGAR O TOTAL -> fazer o while bonitin


if Character.count <= 1400
    ts = '123456789012354'
    public_key = "b091e4f619436453d9a951e666a18be8"
    private_key = "41c8c6053be4b279e2d3c256fb3f782e1f9cc28b"
    x = ts+private_key+public_key
    a = Digest::MD5.hexdigest(x)
    uri = 'https://gateway.marvel.com:443/v1/public/characters?ts='+ts+'&apikey='+public_key+'&hash='+a
    offset = 0
    count = 0
    while(offset <= 1500) do
        response = HTTP.get(uri, :params => {:offset => offset.to_s, :limit => "100"})
        data = JSON.parse(response)["data"]
        data["results"].each do |character|
            thumbnail = character["thumbnail"]
            thumb = thumbnail["path"] + '.' + thumbnail["extension"]
            new_character = Character.new(name: character["name"], description: character["description"], thumbnail: thumb, uuid: character["id"])
            if new_character.save
                puts "salvou o "+new_character.name
            else
                puts "aouhiuheaiuheuiheeiuwqhequihqeuheiuqheqiu"
            end
        end
        offset = offset + 100
        puts(offset)
        puts(Character.count)
    end
else
    puts "Character database updated"
end

