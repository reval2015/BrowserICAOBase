import Foundation
struct Elevation : Codable {
	let feet : Int?
	let meters : Int?

	enum CodingKeys: String, CodingKey {

		case feet = "feet"
		case meters = "meters"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		feet = try values.decodeIfPresent(Int.self, forKey: .feet)
		meters = try values.decodeIfPresent(Int.self, forKey: .meters)
	}

}
