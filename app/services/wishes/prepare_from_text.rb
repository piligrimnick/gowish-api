module Wishes
  class PrepareFromText < ApplicationService
    param :text

    def call
      url = Utils::ParseUrl.call(text: text)

      return { body: text, url: nil } if url.blank?

      metadata = MetaInspector.new(url)

      body = text.gsub(url, '')
      body += "\n\n"
      body += metadata.best_title
      body += "\n\n"
      body += metadata.best_description

      { body: body.strip, url: metadata.canonicals.first&.dig(:href) || url}
    end
  end
end
