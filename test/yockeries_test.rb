require 'minitest/autorun'
require_relative '../yockeries'

module Yockeries
  describe YockHash do
    let(:hash) do
      { 'user_1' => { 'name' => 'robert', 'email' => 'robert@example.com' },
        'user_2' => { 'name' => 'tyler',  'email' => 'ty@example.com' } }
    end

    subject { YockHash.new(hash) }

    it 'symbolizes the keys' do
      subject.get('user_1').key?(:name).must_equal true
    end

    it 'will return the name for user_1' do
      subject.get('user_1')[:name].must_equal 'robert'
    end

    it 'will return the name for user_2' do
      subject.get('user_2')[:name].must_equal 'tyler'
    end

    it 'will return a mock' do
      subject.mock_for('user_1').kind_of?(OpenStruct).must_equal true
    end

    it 'mocks will imitate an object' do
      subject.mock_for('user_1').name.must_equal 'robert'
    end
  end
end
