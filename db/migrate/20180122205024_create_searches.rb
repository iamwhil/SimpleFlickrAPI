class CreateSearches < ActiveRecord::Migration[5.0]
	def change
		create_table :searches do |t|
			t.string :terms, index: true # We can sort on terms, so index.
			t.integer :count, index: true # We can sort on count, so index.
			t.timestamps
		end
	end
end
