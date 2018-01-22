require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  
  	# Make sure that we can search Flickr.
  	test "ensure that the search of Flickr occurs." do
  		search = Search.new(terms: "kitten puppies")
  		search.get_photos
  		assert_equal 10, search.images.length
  	end

  	# Make sure that if the search fails the error is caught

  	# Make sure that multiple searches for the same term incriment the Search count.

  	
end
