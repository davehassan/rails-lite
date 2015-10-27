require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      q_string = req.query_string
      body = req.body
      @params = parse_www_encoded_form(q_string)
      @params.merge!(parse_www_encoded_form(body))
      route_params.each_pair { |key, val| @params[key.to_s] = val}
    end

    def [](key)
      str_key = key.to_s
      @params[str_key]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params = {}
      dummy = params
      return params if www_encoded_form.nil? || www_encoded_form.empty?

      URI::decode_www_form(www_encoded_form).each do |key_nested, val|
        key_array = parse_key(key_nested)
        key_array.each do |key|
          dummy[key] ||= (key == key_array.last ? val : {})
          dummy = dummy[key]
        end
        dummy = params
      end

      params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
