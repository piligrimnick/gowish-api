module Utils
  class DownloadImage < ApplicationService
    option :url

    def call
      StringIO.new(client.get(url).body)
    end

    private

    def client
      @client ||= Faraday.new
    end
  end
end
