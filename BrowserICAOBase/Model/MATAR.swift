
import Foundation
struct METAR: Codable {
	let data : [String]?
	let results : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([String].self, forKey: .data)
		results = try values.decodeIfPresent(Int.self, forKey: .results)
	}

}
