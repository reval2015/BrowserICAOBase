import Foundation
struct Ceiling : Codable {
	let base_feet_agl : Int?
	let base_meters_agl : Int?
	let code : String?
	let feet : Int?
	let meters : Int?
	let text : String?

	enum CodingKeys: String, CodingKey {

		case base_feet_agl = "base_feet_agl"
		case base_meters_agl = "base_meters_agl"
		case code = "code"
		case feet = "feet"
		case meters = "meters"
		case text = "text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		base_feet_agl = try values.decodeIfPresent(Int.self, forKey: .base_feet_agl)
		base_meters_agl = try values.decodeIfPresent(Int.self, forKey: .base_meters_agl)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		feet = try values.decodeIfPresent(Int.self, forKey: .feet)
		meters = try values.decodeIfPresent(Int.self, forKey: .meters)
		text = try values.decodeIfPresent(String.self, forKey: .text)
	}

}
