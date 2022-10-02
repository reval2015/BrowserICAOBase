
import Foundation
struct Humidity : Codable {
	let percent : Int?

	enum CodingKeys: String, CodingKey {

		case percent = "percent"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		percent = try values.decodeIfPresent(Int.self, forKey: .percent)
	}

}
