require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'validations' do
    let(:artist) { Artist.create(name: 'test_artist') }
    it 'is valid' do
      # instantiate a valid album and ensure it is valid
      album = Album.new(name: 'test_name', available: true, artist_id: artist.id)
      expect(album.valid?).to be true
    end

    it 'is invalid without a name' do
      # instantiate an album without a name and ensure it is invalid
      album = Album.new(name: nil, available: 'available', artist_id: artist.id)
      expect(album.valid?).to be false
    end
  end

  describe 'attributes' do
    let(:artist) { Artist.create(name: 'test_artist') }

    it 'has expected attributes' do
      # ensure exactly the expected attributes are present on an album
      album = Album.new(name: 'test_name', available: true, artist_id: artist.id).attribute_names
      expect(album).to contain_exactly('artist_id', 'available', 'created_at', 'id', 'name', 'updated_at')
    end
  end

  context 'scopes' do
    describe '.available' do
      let(:artist) { Artist.create(name: 'test_artist') }
      before do
        Album.create([{ name: 'test_name', available: true, artist_id: artist.id },
                      { name: 'test_name2', available: false, artist_id: artist.id },
                      { name: 'test_name3', available: true, artist_id: artist.id }])
      end
      it 'returns a list of available albums sorted by name' do
        # set up a some available albums and unavailable albums and make expecations that the
        # available albums scope only returns available albums sorted by name
        expect(Album.available.count).to eq 2
      end
    end
  end

  describe '#length_seconds' do
    let(:artist) { Artist.create(name: 'test_artist') }
    let(:album) { Album.new(name: 'test_name3', available: true, artist_id: artist.id)}

    it 'calculates the total length in seconds of an album' do
      # setup a valid album and songs and make expecations about the return value of length seconds
      Song.create([{ title: 'test_title', track_number: 2, length_seconds: 3, album_id: album.id },
                   { title: 'test_title2', track_number: 1, length_seconds: 7, album_id: album.id },
                   { title: 'test_title3', track_number: 3, length_seconds: 4, album_id: album.id }])
      expect(album.length_seconds).to eq 6
    end
  end
end
