require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  
  	# Make sure that we can search Flickr.
  	test "ensure that the search of Flickr occurs." do
  		search = Search.new(terms: "kitten puppies")
  		search.get_photos
  		assert_equal 12, search.images.length
  	end

  	# Make sure that if the search fails the error is caught
  	test "catches an error thrown from Flickr." do
  		search = Search.new(terms: "")
  		search.get_photos
  		assert_equal 3, search.error
  	end

    # Make sure that a Search time is created after the search is saved.
    test "ensures that a SearchTime is created after a search is saved." do 
      search = Search.new(terms: "kettle")
      search.get_photos
      search.save
      assert_equal 1, search.search_times.length
    end
  	
end
