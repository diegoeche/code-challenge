# spec/html_parser_spec.rb
require "spec_helper"
require_relative "../lib/carrousel_parser"
require 'json'

RSpec.describe CarrouselParser do
  context do
    let(:html) {
      File.read("./files/van-gogh-paintings.html")
    }

    it "parses the HTML and returns the right amount of elements" do
      result = CarrouselParser.parse(html)

      expect(result['artworks'].length).to eq(47)
    end

    ["name", "extensions", "link", "image"].each do |attribute|
      it "matches the #{attribute} what was provided as expected output" do
        expected_output_string = File.read("./files/expected-array.json")
        expected_parsed_output = JSON.parse(expected_output_string)
        
        result = CarrouselParser.parse(html)
        result_attribute = result["artworks"][0][attribute]
        expected_attribute = expected_parsed_output["artworks"][0][attribute]

        expect(result_attribute).to eq(expected_attribute)
      end
    end
  end
end
