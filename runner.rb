require './loader'
require 'byebug'

loader = Loader.new(ARGV[0])
data = loader.load
