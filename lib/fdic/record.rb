module FDIC
  class Record
    def initialize(attributes)
      @attributes = attributes
    end

    def [](key)
      @attributes[key.to_s]
    end

    def self.field(method_name, response_key=method_name, &munger)
      munger ||= lambda { |x| x }
      define_method(method_name) {
        value = self[response_key]
        value && munger.call(value)
      }
    end

    def self.int_field(method_name, response_key=method_name)
      field(method_name, response_key, &:to_i)
    end

    def self.currency_field(method_name, response_key=method_name)
      field(method_name, response_key, &:to_f)
    end

    def self.date_field(method_name, response_key=method_name)
      field(method_name, response_key) { |value|
        Date.parse(value)
      }
    end

    def uri
      self['__metadata']['uri']
    end
  end
end
