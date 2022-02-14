class CocheDato < ApplicationRecord
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	settings do
		mappings dynamic: false do
			indexes :car, type: :text, analyzer: :english
			indexes :model, type: :text, analyzer: :english
			indexes :origin, type: :text, analyzer: :english
			indexes :mpg, type: :text, analyzer: :english
			indexes :horsepower, type: :text, analyzer: :english
		end
	end

	def self.searchByCountry(country_origin)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							origin: country_origin
 						}
 					},
 					]
 				}
 			}
 		})
	end

	def self.searchByHorsepower(horsepower)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							horsepower: horsepower
 						}
 					},
 					]
 				}
 			}
 		})
	end

	def self.suggestSearchCarName(query)
 		self.search({
 			size: 25,
 			query: {
				multi_match: {
					query: query,
					fields: [:car]
				}
 			},
			suggest: {
				text: query,
				car: {
					term: {
						size: 1,
						field: :car
					}
				},
			}
 		})
	end

	def self.searchByCarName(query)
 		# self.suggest({
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						multi_match: {
 							query: query,
 							fields: [:car]
 						}
 					},
 					]
 				}
 			}
 		})
 	end

=begin
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
=end

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

	def self.searchByCarNameMpgCountry(query, mpg, country_origin)
 		self.search({
 			size: 25,
			query: {
				bool: {
					must: [
					{
						multi_match: {
							query: query,
							fields: [:car, :model]
						}
					},
					{
						match: {
							mpg: mpg
						}
					},
					{
						match: {
							origin: country_origin
						}
					}
          ]
				}
			}
 		})
	end

	def self.searchByCarNameMpgRangeCountry(query, mpg, mpg_two, country_origin)
 		self.search({
 			size: 25,
 			query: {
				bool: {
					must: [
					{
						multi_match: {
							query: query,
							fields: [:car, :model]
						}
					},
					{
						match: {
							origin: country_origin
						}
					},
						range: {
							mpg: {
								gte: mpg,
								lte: mpg_two,
								boost: 2.0
							}
					}]
				}
 			}
 		})
	end

	def self.searchByCarNameMpgRange(query, mpg, mpg_two)
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
						range: {
							mpg: {
								gte: mpg,
								lte: mpg_two,
								boost: 2.0
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

	def self.searchByModel(model)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							model: model
 						}
 					},
 					]
 				}
 			}
 		})
	end

	def self.searchByQueryModel(query, model)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							car: query
						},
					},
					{
						match: {
							model: model	
 						}
 					},
 					]
 				}
 			}
 		})
	end

	def self.searchByQueryModelCountry(query, model, country_origin)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							car: query
						},
					},
					{
						match: {
							model: model	
 						}
 					},
					{
						match: {
							origin: country_origin	
 						}
					}
 					]
 				}
 			}
 		})
	end

	def self.searchByQueryModelCountryMpg(query, model, country_origin, mpg)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							car: query
						},
					},
					{
						match: {
							model: model	
 						}
 					},
					{
						match: {
							origin: country_origin	
 						}
					},
					{
						match: {
							mpg: mpg	
 						}
					}
 					]
 				}
 			}
 		})
	end

	def self.searchByQueryModelCountryMpgRange(query, model, country_origin, mpg, mpg_two)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							car: query
						},
					},
					{
						match: {
							model: model	
 						}
 					},
					{
						match: {
							origin: country_origin	
 						}
					},
					{
						range: {
							mpg: {
								gte: mpg,
								lte: mpg_two,
								boost: 2.0
							}
						}
					}
 					]
 				}
 			}
 		})
	end

	def self.searchByMpgCountry(mpg, country_origin)
 		self.search({
 			size: 25,
 			query: {
 				bool: {
 					must: [
 					{
 						match: {
 							mpg: mpg
						},
					},
					{
						match: {
							origin: country_origin	
 						}
 					},
 					]
 				}
 			}
 		})
	end

	def self.searchByMpgRangeCountry(country_origin, mpg, mpg_two)
 		self.search({
 			size: 25,
 			query: {
				bool: {
					must: [
						{
							match: {
								origin: country_origin
							}
						},
						{
							range: {
								mpg: {
									gte: mpg,
									lte: mpg_two,
									boost: 2.0
								}
							}
						}
					]
				}
 			}
 		})
	end

	def self.searchByMpgRange(mpg, mpg_two)
 		self.search({
 			size: 25,
 			query: {
				range: {
					mpg: {
						gte: mpg,
						lte: mpg_two,
						boost: 2.0
					}
				}
 			}
 		})
	end

	def self.searchByHorsepowerRange(horsepower, horsepower_two)
 		self.search({
 			size: 25,
 			query: {
				range: {
					horsepower: {
						gte: horsepower,
						lte: horsepower_two,
						boost: 2.0
					}
				}
 			}
 		})
	end

	def self.searchByHorsepowerRangeQuery(horsepower, horsepower_two, query)
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
						range: {
							horsepower: {
								gte: horsepower,
								lte: horsepower_two,
								boost: 2.0
							}
					}]
				}
 			}
 		})
	end

	def self.searchByHorsepowerRangeQueryCountry(horsepower, horsepower_two, query, country_origin)
 		self.search({
 			size: 25,
 			query: {
				bool: {
					must: [
					{
						multi_match: {
							query: query,
							fields: [:car, :model]
						}
					},
					{
						match: {
							origin: country_origin
						}
					},
					range: {
						horsepower: {
							gte: horsepower,
							lte: horsepower_two,
							boost: 2.0
						}
					}]
				}
 			}
 		})
	end

	def self.searchByHorsepowerRangeQueryCountryMpg(horsepower, horsepower_two, query, country_origin, mpg)
 		self.search({
 			size: 25,
 			query: {
				bool: {
					must: [
					{
						multi_match: {
							query: query,
							fields: [:car, :model]
						}
					},
					{
						match: {
							origin: country_origin
						}
					},
					{
						match: {
							mpg: mpg
						}
					},
					range: {
						horsepower: {
							gte: horsepower,
							lte: horsepower_two,
							boost: 2.0
						}
					}]
				}
 			}
 		})
	end

	def self.searchByHorsepowerRangeQueryCountryMpgRange(horsepower, horsepower_two, query, country_origin, mpg, mpg_two)
 		self.search({
 			size: 25,
 			query: {
				bool: {
					must: [
					{
						multi_match: {
							query: query,
							fields: [:car, :model]
						}
					},
					{
						match: {
							origin: country_origin
						}
					},
					range: {
						horsepower: {
							gte: horsepower,
							lte: horsepower_two,
							boost: 2.0
						}
					},
					range: {
						mpg: {
							gte: mpg,
							lte: mpg_two,
							boost: 2.0
						}
					}]
				}
 			}
 		})
	end

end
