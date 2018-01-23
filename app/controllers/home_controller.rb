require 'net/http'

class HomeController < ApplicationController

	before_action :get_search, only: [:show]

	# Returns the index page.
	# The index page will load all previous searches for the history.
	# The index page will also create a Search based on passed in parameters.
	def index
		@order_term = build_order # Utilized to set the default or current order method in the view's form.
		@searches = Search.all.order(@order_term)
		@search = Search.find_by(terms: search_param_terms)
		unless @search
			@search = Search.new(terms: search_param_terms, count: 0)
		end
		@search.get_photos
		unless @search.error.nil? && @search.update_count && @search.save
			flash[:alert] = "Unable to update your search! Flickr error: #{@search.error}"
		end
	end

	# Renders the search results after the historical searches have been updated.
	# This is in contrast to re-running the search query or performing and AJAX 
	# request and updating the historical searches.
	def show
		@order_term = build_order
		@searches = Search.all.order(@order_term)
		@search.get_photos
	end

	private

		# Please refrain from trusting the internet.
		# Passing back just a string instead of a hash, so that the new search can have 
		# its initial count set to 0.
		def search_param_terms
			p = params.permit(:terms, :order)
			p['terms']
		end

		# Builds the search order string.
		def build_order
			p = params.permit(:terms, :order)
			if p['order']
				attribute, asc_desc = p['order'].split(" ")
				if ['terms', 'count', 'updated_at'].include?(attribute) && ['asc', 'desc'].include?(asc_desc)
					return "#{attribute} #{asc_desc}"
				end
			end
			return "updated_at desc"
		end

		# Finds a historical search record.
		def get_search
			@search = Search.find(params[:id])
		end

end
