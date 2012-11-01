# encoding: UTF-8

require 'classifier'
require 'madeleine'
require 'awesome_print'

class Massager
  def initialize(argf)
    @cache = {}
    argf.each do |line|
      last, *elems = line.split(' ').reverse
      label = last.split(':')[1].to_sym
      @cache[label] ||= ""
      elems.each do |e|
        word, count = e.split(':')
        count.to_i.times do
          @cache[label] << word
          @cache[label] << " "
        end
      end
    end
  end

  def method_missing(func)
    return @cache[func]
  end
    
end

args = Massager.new(ARGF)

puts "Done!"
$stdout.flush

m = SnapshotMadeleine.new("bayes_data", YAML) do
  b = Classifier::Bayes.new "Positive", "Negative"
end

m.system.train_positive args.positive
m.system.train_negative args.negative
m.take_snapshot
puts m.system.classify "thanks for all your help"
puts "now, trying to reload snapshot"

m2 = SnapshotMadeleine.new("bayes_data", YAML)
puts m2.system.classify "thanks for all your help"
