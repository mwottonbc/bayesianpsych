require 'classifier'
require 'madeleine'

m = SnapshotMadeleine.new("bayes_data", YAML)

ARGF.each do |line|
  puts line
  puts m.system.classify line
end
