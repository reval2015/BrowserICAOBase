import Foundation
struct METAR_Data : Codable {
	let barometer : Barometer?
	let clouds : [Clouds]?
    let conditions: [Conditions]?
	let dewpoint : Dewpoint?
	let elevation : Elevation?
	let flight_category : String?
	let humidity : Humidity?
	let icao : String?
	let observed : String?
	let raw_text : String?
	let station : Station?
	let temperature : Temperature?
	let visibility : Visibility?
	let wind : Wind?

	enum CodingKeys: String, CodingKey {

		case barometer = "barometer"
        case conditions = "conditions"
		case clouds = "clouds"
		case dewpoint = "dewpoint"
		case elevation = "elevation"
		case flight_category = "flight_category"
		case humidity = "humidity"
		case icao = "icao"
		case observed = "observed"
		case raw_text = "raw_text"
		case station = "station"
		case temperature = "temperature"
		case visibility = "visibility"
		case wind = "wind"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		barometer = try values.decodeIfPresent(Barometer.self, forKey: .barometer)
        conditions = try values.decodeIfPresent([Conditions].self, forKey: .conditions)
		clouds = try values.decodeIfPresent([Clouds].self, forKey: .clouds)
		dewpoint = try values.decodeIfPresent(Dewpoint.self, forKey: .dewpoint)
		elevation = try values.decodeIfPresent(Elevation.self, forKey: .elevation)
		flight_category = try values.decodeIfPresent(String.self, forKey: .flight_category)
		humidity = try values.decodeIfPresent(Humidity.self, forKey: .humidity)
		icao = try values.decodeIfPresent(String.self, forKey: .icao)
		observed = try values.decodeIfPresent(String.self, forKey: .observed)
		raw_text = try values.decodeIfPresent(String.self, forKey: .raw_text)
		station = try values.decodeIfPresent(Station.self, forKey: .station)
		temperature = try values.decodeIfPresent(Temperature.self, forKey: .temperature)
		visibility = try values.decodeIfPresent(Visibility.self, forKey: .visibility)
		wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
	}

}
