require 'faraday'
require 'nokogiri'

class WebScraper
	attr_reader :html_content
	attr_reader :article

	def initialize(url)
		@url = url
		@html_content = nil
		@article = {}
	end

	def scrape
		conn = Faraday.new(url: @url)
		response = conn.get

		if response.success?
			@html_content = response.body
			parse_to_hash
		else
			raise "Failed to retrieve content from #{@url}"
		end
	end

	private
	def parse_to_hash
		doc = Nokogiri::HTML(html_content)
		@article[:title] = doc.css('.newsie-titler').first.text
		location_and_date = doc.css('.topnewstext').first.text.strip
		text_array = location_and_date.split("\r\n")
		date = text_array.last.strip
		@article[:location] = text_array.first.gsub(",","")
		@article[:article] = doc.css(".main-newscopy p")[0..-2].text
		@article[:date] = Date.parse(date).strftime("%Y-%m-%d")
	end

end


def test_scraper(url)
	scraper = WebScraper.new(url)
	scraper.scrape
	scraper.article
end


url = 'https://agriculture.house.gov/news/documentsingle.aspx?DocumentID=2106'
puts test_scraper(url)