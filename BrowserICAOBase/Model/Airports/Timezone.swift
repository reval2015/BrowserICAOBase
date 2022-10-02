import Foundation
struct Timezone : Codable {
	let dst : Int?
	let gmt : String?
	let tzid : String?
	let zone : String?

	enum CodingKeys: String, CodingKey {

		case dst = "dst"
		case gmt = "gmt"
		case tzid = "tzid"
		case zone = "zone"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dst = try values.decodeIfPresent(Int.self, forKey: .dst)
		gmt = try values.decodeIfPresent(String.self, forKey: .gmt)
		tzid = try values.decodeIfPresent(String.self, forKey: .tzid)
		zone = try values.decodeIfPresent(String.self, forKey: .zone)
	}

}
