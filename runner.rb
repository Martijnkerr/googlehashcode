require './loader'
require 'byebug'

loader = Loader.new(ARGV[0])
loader.load
videos_by_endpoint = loader.video_requests.group_by { |vr| vr[:endpoint_idx] }
