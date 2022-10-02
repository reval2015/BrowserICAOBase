import Foundation
struct Geometry : Codable {
	let coordinates : [Double]?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case coordinates = "coordinates"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		coordinates = try values.decodeIfPresent([Double].self, forKey: .coordinates)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}
