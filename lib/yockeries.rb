require 'yaml'
require 'ostruct'

module Yockeries
  class YockHash < Hash
    def initialize(hash = {})
      @hash = symbolize_keys(hash)
    end

    def get(name)
      @hash[name.to_sym]
    end

    def mock_for(name)
      OpenStruct.new(get(name))
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
      dir = File.exists?('test') ? 'test' : 'spec'
      ::Yockeries::YockHash.new(YAML.load_file("#{dir}/fixtures/#{filename.to_s}.yaml"))
    end
  end
end
