require 'rails_helper'

RSpec.describe Album, Artist, type: :model do
  before do
    @artist_id = 1
  end
  describe "validations" do
    it "is valid" do
            # instantiate a valid album and ensure it is valid
      album = Album.new({name: "tname"})

      result = album.available

      expect(result).to eq(true)
    end

    it "is invalid without a name" do
            # instantiate an album without a name and ensure it is invalid
      album = Album.new({name: nil, artist_id: @artist_id})

      result = album.available

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
        @artist_id = 1
        a1 =  Album.new({name: :valid1, artist_id: @artist_id })
        a9 =  Album.new({name: :valid9, artist_id: @artist_id })
        a2 =  Album.new({name: :valid2, artist_id: @artist_id })
        a3 =  Album.new({name: :valid3, artist_id: @artist_id })
        a4 =  Album.new({name: :valid4, artist_id: @artist_id })  
        na1 =  Album.new({name: :invalid1, artist_id: @artist_id })
        na2 =  Album.new({name: :invalid1, artist_id: @artist_id })
        na3 =  Album.new({name: :invalid1, artist_id: @artist_id })        
        @albums = [a1, a9, a2, a3, a4, na1, na2, na3 ]      
        # @albums = Album.create!([
        #   {name: :valid1, artist_id: @artist_id },
        #   {name: :valid2, artist_id: @artist_id },
        #   {name: :valid3, artist_id: @artist_id },
        #   {name: :valid9, artist_id: @artist_id }          
        # ])

        # Album.create!([
        #   {name: :valid1, artist_id: @artist_id },
        #   {name: :valid2, artist_id: @artist_id },
        #   {name: :valid3, artist_id: @artist_id },
        #   {name: :valid9, artist_id: @artist_id }
        #   # {name: nil, artist_id: @artist_id },
        #   # {name: nil, artist_id: @artist_id },
        #   # {name: nil, artist_id: @artist_id }            
        # ])        
      end
      it "returns a list of available albums sorted by name" do
        # set up a some available albums and unavailable albums and make expecations that the
        # available albums scope only returns available albums sorted by name
        

      

        result = @albums.select { |a| a.available }

        expect(result.count).to eq 5
        expect(result.first.name).to eq("valid1")
        expect(result.last.name).to eq("valid9")
        expect(result.any? {|album| album.name.nil? }).to be(false)
      end
    end
  end

  describe "#length_seconds" do
    it "calculates the total length in seconds of an album" do
      # setup a valid album and songs and make expecations about the return value of length seconds
      # album = Album.new({name: "tname", artist_id: 1})
      # album.save!
      # salbum = Album.create!({name: :tname, artist_id: 1}, :without_protection => true )
      salbum = Album.new({ :name => 'Jamie', :artist_id => 1 })
      salbum.save!
      # salbum = Album.find_by name: "tname"
      songs = Song.create!([
        {title: :s1, length_seconds: 60, track_number: 1, album_id: salbum.id},
        {title: :s2, length_seconds: 140, track_number: 1, album_id: salbum.id},
        {title: :s3, length_seconds: 200, track_number: 1, album_id: salbum.id},
        {title: :s4, length_seconds: 600, track_number: 1, album_id: salbum.id}        
      ])
      album.songs = songs

      result = album.length_seconds

      expect(result).to eq 1000

    end
  end
end
