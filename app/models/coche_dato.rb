class CocheDato < ApplicationRecord
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks

	settings index: {
		 analysis: {
			 filter: {
				 # we define custom token filter with name autocomplete
				 autocomplete: {
					 type: :edge_ngram,
					 min_gram: 1,
					 max_gram: 10
				 }# ,
=begin
				 whitespace_merge: {
					 pattern: "\s+",
					 type: :pattern_replace,
					 replacement: " ",
				 },
				 edgengram: {
					 type: :edge_ngram,
					 min_gram: 1,
					 max_gram: 32
				 }
=end
			 },
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
				 }# ,
=begin
				 first_word_name_analyzer: {
					 type: :custom,
					 tokenizer: :keyword,
					 filter: %i[lowercase whitespace_merge edgengram]
				 }
=end
			 }
		 }
  } do
		mappings dynamic: false do
			# indexes :car, type: :text, analyzer: :autocomplete # WORKS ORGINAL
			indexes :car, type: :text do
				indexes :car, type: :text, analyzer: :autocomplete
				# indexes :car, type: :text, analyzer: :first_word_name_analyzer
				indexes :raw, type: :keyword #, analyzer: :keyword
			end
			indexes :model, type: :text, analyzer: :english
			indexes :origin, type: :text, analyzer: :autocomplete
			indexes :mpg, type: :text, analyzer: :english
			indexes :horsepower, type: :text, analyzer: :english
		end
	end

	def self.suggestSearchCarName(query)
 		self.search({
			size: 50,
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

	def self.suggestCarNameOrigin(query, country_origin)
		self.search({
			size: 100,
			query: {
				match: {
					"car.car": {
						query: query
					}
				}
			}# ,
=begin
			sort: [
				{
					"car.raw": {
						"order": "asc"
					}
				}
			]
=end
		})
	end
=begin
#############
# WORKS (sorta)
 			query: {
				bool: {
					should: [
					{
						bool: {
							should: [
							{
								match: {
									car: query
								}
							},
							{
								match: {
									origin: country_origin
								}
							}
							]
						},
						bool: {
							should: [
							{
								match_phrase: {
									car: {
											query: query,
											boost: 20
										}
									}
								},
							 {
								match_phrase: {
									origin: {
										query: country_origin,
										boost: 20
									}
								}
							}
							]
						}
					}
					]
				}
 			}
		})
	end
=end
=begin
						{
							match_phrase: {
								car: query,
								_name: "exact_match"
							}
						},
						{
							match: {
								origin: country_origin,
								_name: "partial_match"
							}
						}
					]
				}
====================
				match_phrase: {
					car: query
				},
				bool: {
					must: [
						match: {
							origin: country_origin
						}
					]
				}
=end

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
