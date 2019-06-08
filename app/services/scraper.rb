class Scraper
  def self.get_first_image doc
    image_url = doc.at_css("img")&.attr("src")

    parsed_uri = Addressable::URI.parse(image_url)
    unless parsed_uri.host
      parsed_uri.path = '/' + parsed_uri.path

      parse_original_uri = Addressable::URI.parse(url)
      # parsed_uri.scheme = parse_original_uri.scheme
      parsed_uri.origin = parse_original_uri.origin
      image_url = parsed_uri.to_s
    end

    image_url
  end

  def self.get_og_image doc
    doc.at_css("meta[property='og:image']")&.attr("content")
  end

  def self.get_description doc
    description_meta = doc.at_css("meta[name='description'], meta[property='og:description']")
    first_paragraph = doc.css("p").select { |p| p.text.length > 5 }.first
    description = if description_meta
      description_meta["content"]
    else
      first_paragraph
    end
  end

  def self.get_video url
    youtubeRegex = /(?:youtube\.com\/\S*(?:(?:\/e(?:mbed))?\/|watch\/?\?(?:\S*?&?v\=))|youtu\.be\/)([a-zA-Z0-9_-]{6,11})/
    vimeoRegex = /([a-z\:\/]*\/\/)(?:www\.)?vimeo\.com\/(?:channels\/[A-Za-z0-9]+\/)?([A-Za-z0-9]+)/

    youtubeMatch = url.match(youtubeRegex)

    if youtubeMatch
      vid = youtubeMatch[youtubeMatch.length-1]
      "https://www.youtube.com/oembed?url=http://www.youtube.com/watch?v=#{vid}&format=json"
      %Q(<iframe width="557" height="270" src="https://www.youtube.com/embed/#{vid}?feature=oembed&autoplay=1" frameborder="0" allowfullscreen></iframe>)
    else
      vimeoMatch = url.match(vimeoRegex)
      if vimeoMatch
        vid = vimeoMatch[2]
        "https://vimeo.com/api/oembed.json?url=https://vimeo.com/#{vid}"

        %Q(<iframe src="https://player.vimeo.com/video/#{vid}?autoplay=1" width="640" height="360" frameborder="0" title="" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>)
      end
    end
  end

  def self.scrape url
    doc = Nokogiri::HTML(Typhoeus.get(url).body)
    title = doc.at_css("title").text.strip

    {
      title: title,
      description: get_description(doc),
      image: get_og_image(doc),
      video: get_video(url),
      url: url
    }
  end
end