module Utils
  class ParseUrl < ApplicationService
    option :text

    def call
      URI.extract(text).first
    end
  end
end
