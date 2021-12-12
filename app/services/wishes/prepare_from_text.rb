module Wishes
  class PrepareFromText < ApplicationService
    param :text

    def call
      url = Utils::ParseUrl.call(text: text)

      return { body: text, url: nil } if url.blank?

      metadata = MetaInspector.new(url, allow_redirections: false)

      return { body: text, url: url } if metadata.response.status != 200

      body = text.gsub(url, '').to_s
      body += "\n\n"
      body += metadata.best_title.to_s
      body += "\n\n"
      body += metadata.best_description.to_s

      {
        body: body.strip,
        url: metadata.canonicals.first&.dig(:href) || url,
        picture: Utils::DownloadImage.call(url: metadata.images.best)
      }
    end
  end
end
