# gem "car_data_gem"


require 'open-uri'
require 'csv'

module Car
	class CarData
		@allCars = Hash.new

		def self.getCSV
			url = "https://perso.telecom-paristech.fr/eagan/class/igr204/data/cars.csv"
			url_data = open(url).read()
			newData = url_data.split(/\n+|\r+/).reject(&:empty?)
			newData.each do |row| 
				splitString = row.split(";")
				tmpCarData = Hash.new
				tmpCarData["MPG"] = splitString[1]
				tmpCarData["Cylinders"] = splitString[2]
				tmpCarData["Displacement"] = splitString[3]
				tmpCarData["Horsepower"] = splitString[4]
				tmpCarData["Weight"] = splitString[5]
				tmpCarData["Acceleration"] = splitString[6]
				tmpCarData["Model"] = splitString[7]
				tmpCarData["Origin"] = splitString[8]
				@allCars[splitString[0]] = tmpCarData
			end
		end

		def self.getAllCars
			return @allCars
		end

		def self.getCar(carName)
			return @allCars[carName]
		end

		def self.getCarMPG(carName)
			return @allCars[carName]["MPG"]
		end

		def self.getCarCylinders(carName)
			return @allCars[carName]["Cylinders"]
		end

		def self.getCarDisplacement(carName)
			return @allCars[carName]["Displacement"]
		end

		def self.getCarHorsepower(carName)
			return @allCars[carName]["Horsepower"]
		end

		def self.getCarWeight(carName)
			return @allCars[carName]["Weight"]
		end

		def self.getCarAcceleration(carName)
			return @allCars[carName]["Acceleration"]
		end

		def self.getCarModel(carName)
			return @allCars[carName]["Model"]
		end

		def self.getCarOrigin(carName)
			return @allCars[carName]["Origin"]
		end

	end
end



namespace :create_datum do
  desc "TODO"
  task generate_car_data: :environment do
    @allCars = Hash.new

		url = "https://perso.telecom-paristech.fr/eagan/class/igr204/data/cars.csv"
		url_data = open(url).read()
		newData = url_data.split(/\n+|\r+/).reject(&:empty?)
		newData.each do |row| 
			splitString = row.split(";")
			tmpCarData = Hash.new
			tmpCarData["Name"] = splitString[0]
			tmpCarData["MPG"] = splitString[1]
			tmpCarData["Cylinders"] = splitString[2]
			tmpCarData["Displacement"] = splitString[3]
			tmpCarData["Horsepower"] = splitString[4]
			tmpCarData["Weight"] = splitString[5]
			tmpCarData["Acceleration"] = splitString[6]
			tmpCarData["Model"] = splitString[7]
			tmpCarData["Origin"] = splitString[8]
			@allCars[splitString[0]] = tmpCarData
		end 

		puts "about to enter @carData for loop"
		@allCars.each do |key, value| 
			coche = CocheDato.new
			coche.car = value['Name']
			coche.mpg = value['MPG'].to_f
			coche.cylinders = value['Cylinders'].to_i
			coche.displacement = value['Displacement'].to_f
			coche.horsepower = value['Horsepower'].to_f
			coche.weight = value['Weight'].to_f
			coche.acceleration = value['Acceleration'].to_f
			coche.model = value['Model'].to_i
			coche.origin = value['Origin']
			coche.save
		end
  end

end
