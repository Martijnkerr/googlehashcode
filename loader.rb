class Loader
  def initialize(file_path)
    @file_path = file_path
  end

  def load
    file = File.open(@file_path, 'r')
    videos, endpoints, requests, caches, capacity = file.readline.split.map { |d| d.to_i }
  end
end
