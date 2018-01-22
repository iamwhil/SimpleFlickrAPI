require 'net/http'

class HomeController < ApplicationController

	# Returns the index page.
	# The index page will load all previous searches for the history.
	# The index page will also create a Search based on passed in parameters.
	def index
		@searches = Search.all
		@search = Search.find_by(terms: search_param_terms)
		unless @search
			@search = Search.new(terms: search_param_terms, count: 0)
		end
		@search.get_photos
		unless @search.error.nil? && @search.update_count && @search.save
			flash[:alert] = "Unable to update your search! Flickr error: #{@search.error}"
		end
	end

	private

		# Please refrain from trusting the internet.
		# Passing back just a string instead of a hash, so that the new search can have 
		# its initial count set to 0.
		def search_param_terms
			p = params.permit(:terms)
			p['terms']
		end

end
