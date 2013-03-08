class HTTPClient
  RUBYMOTION_ENV = :development
  ERROR_SERVER_UNAVAILABLE = "Server Unavailable"

  class << self
    def get(path, parameters = {}, &block)
      AFMotion::Client.shared.get(domain + path, parameters) do |response|
        handle_http_response(response, &block)
      end
    end

    def post(path, parameters = {}, &block)
      AFMotion::Client.shared.post(domain + path, parameters) do |response|
        handle_http_response(response, &block)
      end
    end

    private

    def handle_http_response(response, &block)
      if response.success?
        block.call(true, response.object)
      elsif response.failure?
        p "[HTTP REQUEST FAIL]"
        if data = response.operation.responseJSON
          block.call(false, data)
          p data
        else
          block.call(false, { :error => ERROR_SERVER_UNAVAILABLE})
          p ERROR_SERVER_UNAVAILABLE
        end
      end
    end

    def domain
      case RUBYMOTION_ENV
      when :production
        "http://giasudientu.com/api/"
      when :development
        "http://localhost:3000/api/"
      end
    end
  end
end
