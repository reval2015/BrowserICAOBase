import Foundation
struct Conditions : Codable {
	let code : String?
    let prefix : String?
	let text : String?

	enum CodingKeys: String, CodingKey {

		case code = "code"
        case prefix = "prefix"
		case text = "text"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
        prefix = try values.decodeIfPresent(String.self, forKey: .prefix)
		text = try values.decodeIfPresent(String.self, forKey: .text)
	}

}
