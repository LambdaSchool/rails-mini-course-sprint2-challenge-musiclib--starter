class SongSorter
  def initialize(songs, sort_type)
    @songs = songs
    @sort_type = sort_type
  end
  def sort()
    if @sort_type == "random"
      return @songs.to_a.shuffle
    end
    if @sort_type == "reverse"
      return @songs.to_a.reverse
    end
    return @songs

  end
end
