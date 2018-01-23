# SearchTime is utilized to normalize the Search database.
# Instead of having a new Search for every search formed, we will keep 
# track of the search times with the SearchTime model.
# This is a reference to the Search.id.
class SearchTime < ApplicationRecord

	belongs_to :search
	
end
