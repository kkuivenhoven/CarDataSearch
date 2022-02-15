class CocheDato < ApplicationRecord
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

			# indexes :car
			# indexes :car, type: :text, analyzer: :english
			# indexes :car, type: :completion, analyzer: :english, search_analyzer: :autocomplete
			# indexes :car, type: :completion, analyzer: :autocomplete
=begin
      indexes :car, type: :text, analyzer: :english do
        indexes :keyword, type: "keyword"
        indexes :suggest, type: "completion"
      end
=end
	# settings do

=begin
	settings index: {
    analysis: {
      filter: {
        autocomplete_filter: { 
          type: 'edge_ngram',
					min_gram: 1,
					max_gram: 20
        } 
      },
      analyzer: {
        autocomplete: {
          type: 'custom',
					tokenizer: 'edge_ngram',
          filter: ['lowercase', 'autocomplete_filter'],
        }
      }
    }
=end
	settings index: {
		 analysis: {
			 analyzer: {
				 # we define custom analyzer with name autocomplete
				 autocomplete: {
					 # type should be custom for custom analyzers
					 type: :custom,
					 # we use standard tokenizer
					 tokenizer: :standard,
					 # we apply two token filters
					 # autocomplete filter is a custom filter that we defined above
					 filter: %i[lowercase autocomplete]
				 }
			 },
			 filter: {
				 # we define custom token filter with name autocomplete
				 autocomplete: {
					 type: :edge_ngram,
					 min_gram: 1,
					 max_gram: 25
				 }
			 }
		 }
  } do
		mappings dynamic: false do
			# indexes :car, type: :text, analyzer: :autocomplete_filter
			# indexes :car, type: :text, analyzer: :english, search_analyzer: "autocomplete"
			indexes :car, type: :text, analyzer: :autocomplete
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
 			query: {
				match: {
					car: {
						query: query,
						fuzziness: 1
					}
				}
 			}
		})
	end
=begin
 		self.search({
 			size: 25,
			suggest: {
				text: query,
				car: {
					term: {
						analyzer: :standard,
						field: :car,
						min_word_length: 1,
						suggest_mode: :always
					}
				}
			}
 		})
===============
 			query: {
				multi_match: {
					query: query,
					fields: [:car]
				}
 			}# ,
			suggest: {
				text: query,
				car: {
					term: {
						analyzer: :standard,
						field: :car,
						min_word_length: 1,
						suggest_mode: :always
					}
				},
			}
=end
=begin
 		self.search({
 			query: {
				multi_match: {
					query: query,
					fields: [:car]
				}
 			},
			suggest: {
				suggestions: {
					prefix: query,
					completion: {
						field: :car,
						size: 5
					}
				}
			}
 		})
=================
 		self.search({
			suggest: {
				car: {
					prefix: query,
					completion: {
						field: :car,
						size: 5
					}
				}
			}
 		})
=================
 		self.search({
			size: 25,
			"suggest": {
				"auto-complete-suggest": {
					"prefix": "#{query}",
					"completion": {
						"size": 5,
						"field": "car"
					}
				}
			}
 		})
	end
===================
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
=end

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
