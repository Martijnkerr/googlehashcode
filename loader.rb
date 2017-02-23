class Loader
  attr_reader :latencies

  def initialize(file_path)
    @file_path = file_path
  end

  def load
    file = File.open(@file_path, 'r')
    @videos, @endpoints, @requests, @caches, @capacity = file.readline.split.map(&:to_i)
    sizes = file.readline.split.map(&:to_i)

    @latencies = []
    @endpoints.times do
      data_center_latency, cache_servers = file.readline.split.map(&:to_i)
      endpoint_lats = { dc: data_center_latency }
      cache_servers.times do
        id, latency = file.readline.split.map(&:to_i)
        endpoint_lats[id] = latency
      end
      @latencies << endpoint_lats
    end
  end
end
