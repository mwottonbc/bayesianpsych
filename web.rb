require 'sinatra'
require 'classifier'
require 'madeleine'
require 'yaml'
require 'json'

configure do
  ORACLE = SnapshotMadeleine.new("bayes_data", YAML).system
end

get '/happy.json' do
  puts params.inspect
  { :classification => ORACLE.classify(params['text']) }.to_json
end
