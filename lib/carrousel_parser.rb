require 'nokogiri'
require 'ferrum'

class CarrouselParser
  def initialize(html)
    @html = html
  end

  attr_reader :html

  def self.parse(html)
    new(html).parse
  end

  def rendered_html
    browser = Ferrum::Browser.new
    encoded = Base64.strict_encode64(html)
    browser.goto("data:text/html;base64,#{encoded}")
    browser.network.wait_for_idle
    browser.body.tap { |x| File.write("rendered-html.html", x) }
  end

  def parse
    doc = Nokogiri::HTML.parse(rendered_html)

    results = doc.css("a").select do |a|
      children = a.element_children

      img = children[0]&.name == "img"
      outer_div = children[1]&.name == "div"
      inner_divs = children[1]&.element_children&.length == 2

      img && outer_div && inner_divs
    end.map do |a|
      img = a.element_children[0]
      img_url = img["data-iurl"] || img["data-src"] || img["src"]

      title, extensions = a.element_children[1].element_children.map(&:text)
      {
        'name' => title,
        'extensions' => [extensions],
        'link' => "https://www.google.com#{a["href"]}",
        'image' => img_url
      }
    end

    {
      'artworks' => results
    }
  end
end
