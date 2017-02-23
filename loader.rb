class Loader
  attr_reader :latencies
  attr_reader :capacity
  attr_reader :video_requests
  attr_reader :video_sizes

  def initialize(file_path)
    @file_path = file_path
  end

  def load
    file = File.open(@file_path, 'r')
    @videos_no, @endpoints, @requests, @caches, @capacity = file.readline.split.map(&:to_i)
    @video_sizes = file.readline.split.map(&:to_i)

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

    @video_requests = []
    @requests.times do
      video_id, endpoint_idx, requests_no = file.readline.split.map(&:to_i)
      @video_requests << {video_id: video_id,
                          endpoint_idx: endpoint_idx,
                          requests_no: requests_no}
    end
  end
end
