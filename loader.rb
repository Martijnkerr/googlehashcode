class Loader
  attr_reader :latencies
  attr_reader :capacity

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

    @requests.times do
      video_id, endpoint_idx, requests_no = file.readline.split.map(&:to_i)
      @latencies[endpoint_idx][:requests] = {} if @latencies[endpoint_idx][:requests].nil?
      @latencies[endpoint_idx][:requests][video_id] = requests_no
    end
  end
end
