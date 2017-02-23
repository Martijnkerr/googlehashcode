require './loader'
require 'byebug'

loader = Loader.new(ARGV[0])
loader.load
