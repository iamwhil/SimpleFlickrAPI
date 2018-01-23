class CreateSearchTimes < ActiveRecord::Migration[5.1]
	def change
		create_table :search_times do |t|
			t.integer :search_id, index: true
			t.timestamps
		end
	end
end
