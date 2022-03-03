# Resources:
# 	• "Search as you type" - https://www.elastic.co/guide/en/elasticsearch/reference/current/search-as-you-type.html
#   • overview of different analyzers - https://realpandablog.wordpress.com/2019/09/11/search-as-you-type-n-grams-suggesters-in-elasticsearch/


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
					 max_gram: 10,
				 }
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
				 }
			 }
		 }
  } do
		mappings dynamic: false do
      indexes :car, type: :text do
        indexes :car, type: :text, analyzer: :autocomplete
        indexes :car, type: :text, search_analyzer: :standard
      end

			indexes :model, type: :text do
				indexes :model, type: :text, analyzer: :autocomplete
				indexes :model, type: :text, search_analyzer: :standard
			end

			indexes :origin, type: :text do
				indexes :origin, type: :text, analyzer: :autocomplete
				indexes :origin, type: :text, search_analyzer: :standard
			end

			indexes :mpg, type: :double
			indexes :horsepower, type: :double
		end
	end



	def self.suggestSearchCarName(query)
 		self.search({
			size: 50,
 			query: {
				multi_match: {
					query: query,
					type: :bool_prefix,
					fields: [
						"car", 
						"car._2gram", 
						"car._3gram"
					]
				}
			}
		})
	end

	def self.suggestCarNameOrigin(query, country_origin)
		self.search({
			size: 100,
			query: {
				multi_match: {
					query: query,
					type: :bool_prefix,
					fields: [
						"car", 
						"car._2gram", 
						"car._3gram"
					]
				}
			}
		})
	end



	def self.noCar_noOrigin_noYear_noMpg_noHorsepower
		# nothing to do here 
	end

	def self.yesCar_noOrigin_noYear_noMpg_noHorsepower(carName)
		self.search({
			size: 100,
			query: {
				multi_match: {
					query: carName,
					type: :bool_prefix,
					fields: [
						"car", 
						"car._2gram", 
						"car._3gram"
					]
				}
			}
		})
	end


	def self.noCar_noOrigin_noYear_noMpg_yesHorsepower(horsepower, horsepower_two)
 		self.search({
 			size: 400,
 			query: {
				range: {
					horsepower: {
						gte: horsepower,
						lte: horsepower_two,
						relation: :intersects
					}
				}
 			}
 		})
	end

	# DONE
	def self.noCar_noOrigin_noYear_yesMpg_noHorsepower(lowerMpg, higherMpg)
		self.search({
			size: 400,
			query: {
				range: {
					mpg: {
						gte: lowerMpg,
						lte: higherMpg,
						relation: :intersects
					}
				}
 			}
 		})
	end

	# DONE
	def self.noCar_noOrigin_noYear_yesMpg_yesHorsepower(lowerMpg, higherMpg, lowerHorsepower, higherHorsepower)
    self.search({
      size: 100, 
      query: {
				bool: {
					must: [
						{
							range: {
								mpg: {
									gte: lowerMpg,
									lte: higherMpg,
									relation: :intersects
								}   
							}  
						},
						{
							range: {
								horsepower: {
									gte: lowerHorsepower,
									lte: higherHorsepower,
									relation: :intersects
								}   
							}   
						}   
					]
				}
			}   
    }) 
	end

	def self.noCar_noOrigin_yesYear_noMpg_noHorsepower(year)
		self.search({
			size: 100,
			query: {
				multi_match: {
					query: year,
					type: :bool_prefix,
					fields: [
						"model",
						"model._2gram",
						"model._3gram",
					]
				}
			}
		})
	end

	# DONE
	def self.noCar_noOrigin_yesYear_noMpg_yesHorsepower(year, horsepowerLower, horsepowerHigher)
		self.search({
      size: 100, 
      query: {
        bool: {
          must: [
						{   
							multi_match: {
								query: year,
								fields: [
									"model", 
									"model._2gram", 
									"model._3gram"
								]
							}   
						},  
						{
							range: {
								horsepower: {
									gte: horsepowerLower,
									lte: horsepowerHigher,
									boost: 2.0 
								}   
							}
						}
					]
        }
      }
    }) 
	end

	def self.noCar_noOrigin_yesYear_yesMpg_noHorsepower(year, mpgLower, mpgHigher)
		self.search({
      size: 100, 
      query: {
        bool: {
          must: [
						{   
							multi_match: {
								query: year,
								fields: [
									"model", 
									"model._2gram", 
									"model._3gram"
								]
							}   
						},  
						{
							range: {
								mpg: {
									gte: mpgLower,
									lte: mpgHigher,
									boost: 2.0 
								}   
							}
						}
					]
        }
      }
    }) 
	end

	def self.noCar_noOrigin_yesYear_yesMpg_yesHorsepower(year, mpgLower, mpgHigher, horsepowerLower, horsepowerHigher)
		self.search({
      size: 100, 
      query: {
        bool: {
          must: [
						{   
							multi_match: {
								query: year,
								fields: [
									"model", 
									"model._2gram", 
									"model._3gram"
								]
							}   
						},  
						{
							range: {
								mpg: {
									gte: mpgLower,
									lte: mpgHigher,
									boost: 2.0 
								}   
							}
						}, 
						{
							range: {
								horsepower: {
									gte: horsepowerLower,
									lte: horsepowerHigher,
									boost: 2.0 
								}   
							}
						} 
					]
        }
      }
    }) 
	end

	def self.noCar_yesOrigin_noYear_noMpg_noHorsepower(origin)
		self.search({
			size: 100,
			query: {
				multi_match: {
					query: origin,
					type: :bool_prefix,
					fields: [
						"origin",
						"origin._2gram",
						"origin._3gram"
					]
				}
			}
		})
	end

	def self.noCar_yesOrigin_noYear_noMpg_yesHorsepower(origin, horsepowerLower, horsepowerHigher)
		self.search({
      size: 100, 
      query: {
        bool: {
          must: [
						{   
							multi_match: {
								query: origin,
								fields: [
									"origin", 
									"origin._2gram", 
									"origin._3gram"
								]
							}   
						},  
						{
							range: {
								horsepower: {
									gte: horsepowerLower,
									lte: horsepowerHigher,
									boost: 2.0 
								}   
							}
						}
					]
        }
      }
    }) 
	end

	def self.noCar_yesOrigin_noYear_yesMpg_noHorsepower(origin, mpgLower, mpgHigher)
		self.search({
      size: 100, 
      query: {
        bool: {
          must: [
						{   
							multi_match: {
								query: origin,
								fields: [
									"origin", 
									"origin._2gram", 
									"origin._3gram"
								]
							}   
						},  
						{
							range: {
								mpg: {
									gte: mpgLower,
									lte: mpgHigher,
									boost: 2.0 
								}   
							}
						}
					]
        }
      }
    }) 
	end

	def self.noCar_yesOrigin_noYear_yesMpg_yesHorsepower(origin, mpgLower, mpgHigher, horsepowerLower, horsepowerHigher)
		self.search({
      size: 100, 
      query: {
        bool: {
          must: [
						{   
							multi_match: {
								query: origin,
								fields: [
									"origin", 
									"origin._2gram", 
									"origin._3gram"
								]
							}   
						},  
						{
							range: {
								mpg: {
									gte: mpgLower,
									lte: mpgHigher,
									boost: 2.0 
								}   
							}
						}, 
						{
							range: {
								horsepower: {
									gte: horsepowerLower,
									lte: horsepowerHigher,
									boost: 2.0 
								}   
							}
						} 
					]
        }
      }
    }) 
	end

	def self.noCar_yesOrigin_yesYear_noMpg_noHorsepower(origin, year)
		self.search({ 
			size: 100,
			query: {
				bool: {
					must: {
						bool: {
							must: [
								{
									multi_match: {
										query: origin,
										type: :phrase_prefix,
										fields: [
											"origin",
											"origin._2gram",
											"origin._3gram",
											"model",
											"model._2gram",
											"model._3gram"
										]
									}
								},
								{
									multi_match: {
										query: year,
										type: :phrase_prefix,
										fields: [
											"origin",
											"origin._2gram",
											"origin._3gram",
											"model",
											"model._2gram",
											"model._3gram"
										]
									}
								}
							],
							should: [],
							must_not: []
						}
					},
					filter: {
						bool: {
							must: {
								bool: {
									must: [],
									should: [],
									must_not: []
								}
							}
						}
					}
				}
			}
		})
	end

	# -> in progress <-
	def self.noCar_yesOrigin_yesYear_noMpg_yesHorsepower(origin, year, horsepowerLower, horsepowerHigher)
		self.search({ 
			size: 100,
			query: {
				bool: {
					must: {
						bool: {
							must: [
								{
									multi_match: {
										query: origin,
										type: :phrase_prefix,
										fields: [
											"origin",
											"origin._2gram",
											"origin._3gram",
										]
									}
								},
								{
									multi_match: {
										query: year,
										type: :phrase_prefix,
										fields: [
											"model",
											"model._2gram",
											"model._3gram"
										]
									}
								},
								{
									range: {
										horsepower: {
											gte: horsepowerLower,
											lte: horsepowerHigher,
											boost: 2.0 
										}   
									}
								}, 
							],
							should: [],
							must_not: []
						}
					},
					filter: {
						bool: {
							must: {
								bool: {
									must: [],
									should: [],
									must_not: []
								}
							}
						}
					}
				}
			}
		})
	end

	def self.noCar_yesOrigin_yesYear_yesMpg_noHorsepower(origin, year, mpgLower, mpgHigher)
		self.search({ 
			size: 100,
			query: {
				bool: {
					must: {
						bool: {
							must: [
								{
									multi_match: {
										query: origin,
										type: :phrase_prefix,
										fields: [
											"origin",
											"origin._2gram",
											"origin._3gram",
										]
									}
								},
								{
									multi_match: {
										query: year,
										type: :phrase_prefix,
										fields: [
											"model",
											"model._2gram",
											"model._3gram"
										]
									}
								},
								{
									range: {
										mpg: {
											gte: mpgLower,
											lte: mpgHigher,
											boost: 2.0 
										}   
									}
								}, 
							],
							should: [],
							must_not: []
						}
					},
					filter: {
						bool: {
							must: {
								bool: {
									must: [],
									should: [],
									must_not: []
								}
							}
						}
					}
				}
			}
		})
	end

	def self.noCar_yesOrigin_yesYear_yesMpg_yesHorsepower
	end

	def self.yesCar_noOrigin_noYear_noMpg_yesHorsepower
	end

	def self.yesCar_noOrigin_noYear_yesMpg_noHorsepower
	end

	def self.yesCar_noOrigin_noYear_yesMpg_yesHorsepower
	end

	def self.yesCar_noOrigin_yesYear_noMpg_noHorsepower(carName, year)
		self.search({ 
			size: 100,
			query: {
				bool: {
					must: {
						bool: {
							must: [
								{
									multi_match: {
										query: carName,
										type: :phrase_prefix,
										fields: [
											"car",
											"car._2gram",
											"car._3gram",
										]
									}
								},
								{
									multi_match: {
										query: year,
										type: :phrase_prefix,
										fields: [
											"model",
											"model._2gram",
											"model._3gram"
										]
									}
								}
							],
							should: [],
							must_not: []
						}
					},
					filter: {
						bool: {
							must: {
								bool: {
									must: [],
									should: [],
									must_not: []
								}
							}
						}
					}
				}
			}
		})
	end

	def self.yesCar_noOrigin_yesYear_noMpg_yesHorsepower
	end

	def self.yesCar_noOrigin_yesYear_yesMpg_noHorsepower
	end

	def self.yesCar_noOrigin_yesYear_yesMpg_yesHorsepower
	end

	def self.yesCar_yesOrigin_noYear_noMpg_yesHorsepower
	end

	def self.yesCar_yesOrigin_noYear_noMpg_noHorsepower(carName, origin)
		self.search({ 
			size: 100,
			query: {
				bool: {
					must: {
						bool: {
							must: [
								{
									multi_match: {
										query: carName,
										type: :phrase_prefix,
										fields: [
											"car",
											"car._2gram",
											"car._3gram",
										]
									}
								},
								{
									multi_match: {
										query: origin,
										type: :phrase_prefix,
										fields: [
											"origin",
											"origin._2gram",
											"origin._3gram"
										]
									}
								}
							],
							should: [],
							must_not: []
						}
					},
					filter: {
						bool: {
							must: {
								bool: {
									must: [],
									should: [],
									must_not: []
								}
							}
						}
					}
				}
			}
		})
	end

	def self.yesCar_yesOrigin_noYear_yesMpg_noHorsepower
	end

	def self.yesCar_yesOrigin_noYear_yesMpg_yesHorsepower
	end

	def self.yesCar_yesOrigin_yesYear_noMpg_noHorsepower
	end

	def self.yesCar_yesOrigin_yesYear_noMpg_yesHorsepower
	end

	def self.yesCar_yesOrigin_yesYear_yesMpg_noHorsepower
	end

	def self.yesCar_yesOrigin_yesYear_yesMpg_yesHorsepower
	end

end

=begin
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
 					}# ,
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
 					}# ,
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
 					} #,
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
 			size: 400,
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
=end

