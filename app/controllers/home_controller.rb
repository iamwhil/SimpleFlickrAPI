require 'net/http'

class HomeController < ApplicationController

	# Returns the index page.
	# The index page will load all previous searches for the history.
	# The index page will also create a Search based on passed in parameters.
	def index
		@Searches = Searches.all
		puts params.inspect
		if params[:search]
			@Search = Search.new(search_params)
		end
	end

	private

		# Please refrain from trusting the internet.
		def search_params
			puts params.inspect
		end

end
