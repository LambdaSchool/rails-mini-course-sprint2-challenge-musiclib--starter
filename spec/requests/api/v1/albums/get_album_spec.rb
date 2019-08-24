require 'rails_helper'

RSpec.describe "Get Album", type: :request do
  describe "GET /api/v1/albums/:id" do
    let(:album) {
      artist_id = Artist.create!({name: 'RATM'}).id
      Album.create({name: "Battle of Los Angles", artist_id: artist_id})
    }

    it "gets the album" do
      get api_v1_album_path(album)
      json_body = JSON.parse(response.body).deep_symbolize_keys

      # puts 'json_body'
      # puts json_body[:name]
      expect(response).to have_http_status(200)
      expect(json_body.count).to eq(6)
      expect(json_body[:name]).to include("Battle of Los Angles")
      # write an expectation about the response status code
      # write an expecation about the response json_body
    end
  end
end
