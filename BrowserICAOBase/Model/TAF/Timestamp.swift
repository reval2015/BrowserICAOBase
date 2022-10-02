import Foundation
struct Timestamp : Codable {
	let bulletin : String?
	let from : String?
	let issued : String?
	let to : String?

	enum CodingKeys: String, CodingKey {

		case bulletin = "bulletin"
		case from = "from"
		case issued = "issued"
		case to = "to"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bulletin = try values.decodeIfPresent(String.self, forKey: .bulletin)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		issued = try values.decodeIfPresent(String.self, forKey: .issued)
		to = try values.decodeIfPresent(String.self, forKey: .to)
	}

}
