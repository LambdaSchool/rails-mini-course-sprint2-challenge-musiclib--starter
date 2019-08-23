class SongSorter
  attr_accessor :songs, :sort_value
  def initialize(songs, sort_value)
    self.songs = songs
    self.sort_value = sort_value
  end
  def sort
    if sort_value == 'random'
      songs.to_a.shuffle
    elsif sort_value == 'reverse'
      songs.to_a.reverse
    else
      songs
    end
  end
end
