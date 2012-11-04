require 'yaml'

module Yockeries
  class YockHash < Hash
    attr_reader :hash

    def initialize(hash = {})
      @hash = symbolize_keys(hash)
    end

    def get(name)
      hash[name.to_sym]
    end

    def mock_for(name)
      hashed_mock = get(name)
      ::Struct.new( *(k=hashed_mock.keys)).new( *hashed_mock.values_at(*k) )
    end

    private

    def symbolize_keys(hash)
      case hash
      when Array
        symbolize_array_keys(hash)
      when Hash
        symbolize_hash_keys(hash)
      else
        hash
      end
    end

    def symbolize_array_keys(array)
      array.inject([]) do |result, value|
        result << case value
        when Hash, Array
          symbolize_keys(value)
        else
          value
        end
        result
      end
    end

    def symbolize_hash_keys(hash)
      hash.inject({}) do |result, (key,value)|
        nval = case value
        when Hash, Array
          symbolize_keys(value)
        else
          value
        end
        result[key.to_sym] = nval
        result
      end
    end

  end


  module Loader
    def fixture(filename)
      file = Dir.glob("{test,spec}/fixtures/#{filename}.{yaml,yml}").first
      ::Yockeries::YockHash.new(YAML.load_file(file))
    end
  end
end
