import Foundation
struct DataA : Codable {
	let city : String?
	//let country : Country?
	let geometry : Geometry?
	let iata : String?
	let icao : String?
	let latitude : Latitude?
	let longitude : Longitude?
	let name : String?
	let position : Position?
	let state : State1?
	let status : String?
	//let timezone : Timezone?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case city = "city"
		//case country = "country"
		case geometry = "geometry"
		case iata = "iata"
		case icao = "icao"
		case latitude = "latitude"
		case longitude = "longitude"
		case name = "name"
		case position = "position"
		case state = "state"
		case status = "status"
		//case timezone = "timezone"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		//country = try values.decodeIfPresent(Country.self, forKey: .country)
		geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
		iata = try values.decodeIfPresent(String.self, forKey: .iata)
		icao = try values.decodeIfPresent(String.self, forKey: .icao)
		latitude = try values.decodeIfPresent(Latitude.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Longitude.self, forKey: .longitude)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		position = try values.decodeIfPresent(Position.self, forKey: .position)
		state = try values.decodeIfPresent(State1.self, forKey: .state)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		//timezone = try values.decodeIfPresent(Timezone.self, forKey: .timezone)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
