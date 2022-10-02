import Foundation
struct Bearing : Codable {
	let from : Int?
	let to : Int?

	enum CodingKeys: String, CodingKey {

		case from = "from"
		case to = "to"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		from = try values.decodeIfPresent(Int.self, forKey: .from)
		to = try values.decodeIfPresent(Int.self, forKey: .to)
	}

}
