require 'rails_helper'

RSpec.describe Album, Artist, type: :model do
  let (:artist) { Artist.create({:name => "RATM"}) }

  describe "validations" do
    it "is valid" do
            # instantiate a valid album and ensure it is valid
      album = artist.albums.create!({name: "tname"})
      # puts 'valid album'
      # puts album.available

      result = album.available

      expect(result).to eq(true)
    end

    it "is invalid without a name" do
            # instantiate an album without a name and ensure it is invalid
      result = true
      begin
        artist.albums.create!({name: nil})
        puts "invalid test failed"
      
        
      rescue => exception
        
        result = false
        
      end
      # puts 'invalid album'
      # puts album.available

      # result = album.nil?

      expect(result).to eq(false)

    end
  end

  describe "attributes" do
    it "has expected attributes" do
      # ensure exactly the expected attributes are present on an album
      album = Album.new()

      result = album.attribute_names.map(&:to_sym)

      expect(result).to contain_exactly(
        :id,
        :name,
        :artist_id,
        :available,        
        :created_at,
        :updated_at
      )      
    end
  end

  context "scopes" do

       
    describe "available" do
      before do
      
        artist.albums.create!([
          {name: :valid1 },
          {name: :valid2 },
          {name: :valid3 },
          {name: :valid9 }          
        ])

               
      end
      it "returns a list of available albums sorted by name" do
        # set up a some available albums and unavailable albums and make expecations that the
        # available albums scope only returns available albums sorted by name

        result = artist.albums.available

        expect(result.count).to eq 4
        expect(result.first.name).to eq("valid1")
        expect(result.last.name).to eq("valid9")
        expect(result.any? {|album| album.name.nil? }).to be(false)
      end
    end
  end

  describe "#length_seconds" do
    it "calculates the total length in seconds of an album" do
      # setup a valid album and songs and make expecations about the return value of length seconds

      album = artist.albums.new({ :name => 'Jamie'})
      album.save!
      album = Album.find_by name: "Jamie"
      songs = Song.create!([
        {title: :s1, length_seconds: 60, track_number: 1, album_id: album.id},
        {title: :s2, length_seconds: 140, track_number: 1, album_id: album.id},
        {title: :s3, length_seconds: 200, track_number: 1, album_id: album.id},
        {title: :s4, length_seconds: 600, track_number: 1, album_id: album.id}        
      ])
      album.songs = songs

      result = album.length_seconds

      expect(result).to eq 1000

    end
  end
end
