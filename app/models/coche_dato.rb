class CocheDato < ApplicationRecord
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	settings do
		mappings dynamic: false do
			indexes :car, type: :text, analyzer: :english
			indexes :model, type: :text, analyzer: :english
			indexes :origin, type: :text, analyzer: :english
			indexes :mpg, type: :text, analyzer: :english
		end
	end

	def self.searchByCarName(query)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						multi_match: {
 							query: query,
 							fields: [:car, :model, :origin]
 						}
 					},
 					]
 				}
 			}
 		})
 	end

	def self.searchByCarNameMpg(query, mpg)
 		self.search({
 			size: 25,
			query: {
				bool: {
					must: [
					{
						multi_match: {
							query: query,
							fields: [:car, :model, :origin]
						}
					},
					{
						match: {
							mpg: mpg
						}
					}]
				}
    }
 		})
	end

	def self.searchByMpg(mpg)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							mpg: mpg
 						}
 					},
 					]
 				}
 			}
 		})
	end

end
