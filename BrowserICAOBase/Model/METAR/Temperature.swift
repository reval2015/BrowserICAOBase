import Foundation
struct Temperature : Codable {
	let celsius : Int?
	let fahrenheit : Int?

	enum CodingKeys: String, CodingKey {

		case celsius = "celsius"
		case fahrenheit = "fahrenheit"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		celsius = try values.decodeIfPresent(Int.self, forKey: .celsius)
		fahrenheit = try values.decodeIfPresent(Int.self, forKey: .fahrenheit)
	}

}
