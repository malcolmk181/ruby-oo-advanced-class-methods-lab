class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    song.save
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = self.new_by_name(name)
    song.save
    song
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    result = self.find_by_name(name)
    result.nil? ? self.create_by_name(name) : result
  end

  def self.alphabetical
    self.all.sort_by {|song| song.name }
  end

  def self.new_from_filename(filename)
    filename_array = filename.split(' - ')
    artist = filename_array[0]
    
    # substitutes anything starting with . followed by any number of any characters
    # with nothing
    # read from https://ruby-doc.org/core-1.8.6/String.html and https://www.rubyguides.com/2015/06/ruby-regex/
    name = filename_array[1].gsub(/\..+/, '')

    song = self.new_by_name(name)
    song.artist_name = artist
    song
  end

  def self.create_from_filename(filename)
    song = self.new_from_filename(filename)
    song.save
    song
  end

  def self.destroy_all
    @@all.clear
  end
end
