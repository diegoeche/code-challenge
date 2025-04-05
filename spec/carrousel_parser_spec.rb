require "spec_helper"
require_relative "../lib/carrousel_parser"
require 'json'

RSpec.describe CarrouselParser do
  context "with the van-gogh paintings example" do
    before(:context) do
      html = File.read("./files/van-gogh-paintings.html")

      # I'd normally not cache things through tests due to state leaking
      # but in this case it does save a lot of time
      @result = described_class.parse(html)
    end

    it "parses the HTML and returns the right amount of elements" do
      expect(@result['artworks'].length).to eq(47)
    end

    ["name", "extensions", "link", "image"].each do |attribute|
      it "matches the #{attribute} what was provided as expected output" do
        expected_output_string = File.read("./files/expected-array.json")
        expected_parsed_output = JSON.parse(expected_output_string)

        expected_parsed_output.each_with_index do |_, index|
          result_attribute = @result["artworks"][index][attribute]
          expected_attribute = expected_parsed_output["artworks"][index][attribute]
          expect(result_attribute).to eq(expected_attribute)
        end
      end
    end
  end

  context "with the manet paintings example" do
    before(:context) do
      html = File.read("./files/manet-paintings.html")
      # I'd normally not cache things through tests due to state leaking
      # but in this case it does save a lot of time
      @result = described_class.parse(html)
    end

    it "parses the HTML and returns the right amount of elements" do
      expect(@result['artworks'].length).to eq(50)
    end

    let(:expected_output) {
      {
        "artworks" => [
          "name" => "Olympia",
          "extensions" => ["1863"],
          "link" => starting_with("https://www.google.com"),
          "image" => starting_with("data:image/jpeg;base64,")
        ]
      }
    }

    ["name", "extensions", "link", "image"].each do |attribute|
      it "matches the #{attribute} of the first image to the" do
        result_attribute = @result["artworks"][0][attribute]
        expected_attribute = expected_output["artworks"][0][attribute]

        expect(result_attribute).to match(expected_attribute)
      end
    end
  end

  context "with the ballard books example" do
    before(:context) do
      html = File.read("./files/ballard-books.html")
      # I'd normally not cache things through tests due to state leaking
      # but in this case it does save a lot of time
      @result = described_class.parse(html)
    end

    it "parses the HTML and returns the right amount of elements" do
      expect(@result['artworks'].length).to eq(12)
    end

    let(:expected_output) {
      {
        "artworks" => [
          "name" => "Crash",
          "extensions" => ["1973"],
          "link" => starting_with("https://www.google.com"),
          "image" => starting_with("data:image/jpeg;base64,")
        ]
      }
    }

    ["name", "extensions", "link", "image"].each do |attribute|
      it "matches the #{attribute} of the first image to document" do
        result_attribute = @result["artworks"][0][attribute]
        expected_attribute = expected_output["artworks"][0][attribute]

        expect(result_attribute).to match(expected_attribute)
      end
    end
  end
end
