require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

	# The test suite is creating 2 Searches with no terms, destroy them.
	def setup
		Search.destroy_all
	end

	test "makes sure that the index responds." do 
		get root_path
		assert_response :success
	end

	test "make sure that the index responds with a query." do 
		get root_path, params: { terms: "kittens" }
		assert_response :success
	end

	test "make sure that when the same term is searched for twice the count goes up." do 
		get root_path, params: { terms: "kittens" }
		assert_response :success
		search = Search.last
		assert_equal 1, search.count
		get root_path, params: { terms: "kittens" }
		assert_response :success
		search.reload
		assert_equal 2, search.count
	end

end