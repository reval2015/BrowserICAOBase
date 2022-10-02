import Foundation
struct Longitude : Codable {
	let decimal : Double?
	let degrees : String?

	enum CodingKeys: String, CodingKey {

		case decimal = "decimal"
		case degrees = "degrees"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		decimal = try values.decodeIfPresent(Double.self, forKey: .decimal)
		degrees = try values.decodeIfPresent(String.self, forKey: .degrees)
	}

}
