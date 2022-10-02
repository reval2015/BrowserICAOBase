

import Foundation
struct Clouds : Codable {
	let code : String?
	let text : String?
    let meters : Int?
	enum CodingKeys: String, CodingKey {

		case code = "code"
		case text = "text"
        case meters = "meters"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		text = try values.decodeIfPresent(String.self, forKey: .text)
        meters = try values.decodeIfPresent(Int.self, forKey: .meters)
	}

}
