
import Foundation
struct Barometer : Codable {
	let hg : Double?
	let hpa : Double?
	let kpa : Double?
	let mb : Double?

	enum CodingKeys: String, CodingKey {

		case hg = "hg"
		case hpa = "hpa"
		case kpa = "kpa"
		case mb = "mb"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		hg = try values.decodeIfPresent(Double.self, forKey: .hg)
		hpa = try values.decodeIfPresent(Double.self, forKey: .hpa)
		kpa = try values.decodeIfPresent(Double.self, forKey: .kpa)
		mb = try values.decodeIfPresent(Double.self, forKey: .mb)
	}

}
