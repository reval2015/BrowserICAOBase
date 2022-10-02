
import Foundation
struct Metar_Decoded: Codable {
	let data : [METAR_Data]?
	let results : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([METAR_Data].self, forKey: .data)
		results = try values.decodeIfPresent(Int.self, forKey: .results)
	}

}
