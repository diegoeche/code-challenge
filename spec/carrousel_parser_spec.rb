# spec/html_parser_spec.rb
require "spec_helper"
require_relative "../lib/carrousel_parser"
require 'json'

RSpec.describe CarrouselParser do
  context  "with the van-gogh paintings example" do
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

  context  "with the manet paintings example" do
    let(:html) {
      File.read("./files/manet-paintings.html")
    }

    it "parses the HTML and returns the right amount of elements" do
      result = CarrouselParser.parse(html)

      expect(result['artworks'].length).to eq(50)
    end

    ["name", "extensions", "link", "image"].each do |attribute|
      it "matches the #{attribute} that was provided as expected output" do
        expected_output = {
          "artworks" => [
            "name" => "Olympia",
            "extensions" => ["1863"],
            "link" => String,
            "image" => String
          ]
        }

        result = CarrouselParser.parse(html)

        File.write("manet-result.txt", result)
        result_attribute = result["artworks"][0][attribute]
        expected_attribute = expected_output["artworks"][0][attribute]

        expect(result_attribute).to match(expected_attribute)
      end
    end
  end
end
