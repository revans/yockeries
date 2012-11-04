require 'benchmark'
require 'ostruct'
require_relative '../lib/yockeries'

REP = 100000
hash = {'user_1' => { 'name' => 'robert', 'email' => 'robert@example.com' },
        'user_2' => { 'name' => 'tyler',  'email' => 'ty@example.com' } }

Benchmark.bm 20 do |x|
  x.report 'Mock with an OpenStruct' do
    REP.times do |index|
      OpenStruct.new(Yockeries::YockHash.new(hash).get('user_1'))
    end
  end

  x.report 'Mock with a Struct     ' do
    REP.times do |index|
      Yockeries::YockHash.new(hash).mock_for('user_1')
    end
  end
end
