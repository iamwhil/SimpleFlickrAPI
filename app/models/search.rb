# Primary model for searching Flickr.
# A Search is identified by its search terms.
# When search terms are reused the Search's count is updated.
# A Search is not saved until there is a Response from Flickr.

require 'net/http'
#require 'json'

class Search < ApplicationRecord

	attr_accessor :images # Array of returned image urls.
	attr_accessor :error  # Error message returned from Flickr

	# Perform the search on Flickr.
	# Set the images attribute accessor.
	def get_photos
		uri = URI("https://www.flickr.com/services/rest/")
		params = { 	method: 'flickr.photos.search',
					api_key: ENV["PUBLIC_KEY"],
					text: self.terms,
					format: 'json',
					privacy_filter: 1,
					safe_search: 1,
					content_type: 1,
					per_page: 10
				}
		uri.query = URI.encode_www_form(params)
		@res = Net::HTTP.get_response(uri)

		# Flickr API returns an oddly formatted JSON object with a 
		#weird precursor and closing ')', remove it.
		body = @res.body.gsub("jsonFlickrApi(", '')
		body = JSON.parse(body[0, body.length-1])

		# Make sure the the photos are present and there are no errors.
		if body['code']
			self.error = body['code']
		else
			self.images = []
			body['photos']['photo'].each do |p|
				url = "https://farm#{p['farm']}.staticflickr.com/#{p['server']}/#{p['id']}_#{p['secret']}_q.jpg"
				images << url
			end
		end
	end

	# Update Search's count, the number of times this search has been ran.
	def update_count
		self.count += 1
		true
	end

end