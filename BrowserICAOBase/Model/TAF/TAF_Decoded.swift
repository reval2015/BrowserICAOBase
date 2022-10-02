import Foundation
struct TAF_Decoded : Decodable {
	let forecast : [Forecast]?
	let icao : String?
	let raw_text : String?
	let station : Station?
	let timestamp : Timestamp?

	enum CodingKeys: String, CodingKey {

		case forecast = "forecast"
		case icao = "icao"
		case raw_text = "raw_text"
		case station = "station"
		case timestamp = "timestamp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		forecast = try values.decodeIfPresent([Forecast].self, forKey: .forecast)
		icao = try values.decodeIfPresent(String.self, forKey: .icao)
		raw_text = try values.decodeIfPresent(String.self, forKey: .raw_text)
		station = try values.decodeIfPresent(Station.self, forKey: .station)
		timestamp = try values.decodeIfPresent(Timestamp.self, forKey: .timestamp)
	}

}
