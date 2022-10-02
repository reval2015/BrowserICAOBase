
import Foundation
struct Station : Codable {
	let geometry : Geometry?
	let location : String?
	let name : String?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case geometry = "geometry"
		case location = "location"
		case name = "name"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
