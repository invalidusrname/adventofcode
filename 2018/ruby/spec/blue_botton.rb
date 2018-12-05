require 'net/http'

class BlueButtonClient

    attr_reader :host

    def initialize(username, password, host)
        @username = username
        @password = password
        @host = host
    end

    def base_url
        "https://#{host}/v1/"
    end

    def get_token
        uri = URI.parse("#{base_url}/token")
        response = Net:HTTP::Post.new(uri)
        response.body.id
    end

    def authorize
        uri = URI.parse("#{base_url}/authorize?token=#{token}")
        response = Net:HTTP::Post.new(uri)
        response.body.authorized_hash
    end

    def eob(parient_id)
        uri = URI.parse("#{base_url}/eob/#{parient_id}")
        response = Net:HTTP::Get.new(uri)
        data = JSON.parse(response.body)

        EOB.new(data)
    end
end

client = BlueButtonClient.new('user', 'pass', 'sandbox.bluebutton.cms.gov')
token = client.authorize