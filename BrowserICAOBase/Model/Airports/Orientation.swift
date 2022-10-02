import Foundation
struct Orientation : Codable {
	let from : String?
	let to : String?

	enum CodingKeys: String, CodingKey {

		case from = "from"
		case to = "to"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		to = try values.decodeIfPresent(String.self, forKey: .to)
	}

}
