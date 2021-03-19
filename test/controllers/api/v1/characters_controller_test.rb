require 'test_helper'

class Api::V1::CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @character = characters(:one)
  end

  test "should show user" do
    get api_v1_character_url(@character), as: :json
    assert_response :success
    json_response = JSON.parse(self.response.body)
    assert_equal @character.name, json_response['name']
  end
end
