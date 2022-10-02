
import Foundation
struct Wind : Codable {
	let degrees : Int?
	let speed_kph : Int?
	let speed_kts : Int?
	let speed_mph : Int?
	let speed_mps : Int?
    let gust_kph : Int?
    let gust_kts : Float?
    let gust_mph : Int?
    let gust_mps : Int?
	enum CodingKeys: String, CodingKey {

		case degrees = "degrees"
		case speed_kph = "speed_kph"
		case speed_kts = "speed_kts"
		case speed_mph = "speed_mph"
		case speed_mps = "speed_mps"
        case gust_kph = "gust_kph"
        case gust_kts = "gust_kts"
        case gust_mph = "gust_mph"
        case gust_mps = "gust_mps"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		degrees = try values.decodeIfPresent(Int.self, forKey: .degrees)
		speed_kph = try values.decodeIfPresent(Int.self, forKey: .speed_kph)
		speed_kts = try values.decodeIfPresent(Int.self, forKey: .speed_kts)
		speed_mph = try values.decodeIfPresent(Int.self, forKey: .speed_mph)
		speed_mps = try values.decodeIfPresent(Int.self, forKey: .speed_mps)
        gust_kph = try values.decodeIfPresent(Int.self, forKey: .gust_kph)
        gust_kts = try values.decodeIfPresent(Float.self, forKey: .gust_kts)
        gust_mph = try values.decodeIfPresent(Int.self, forKey: .gust_mph)
        gust_mps = try values.decodeIfPresent(Int.self, forKey: .gust_mps)
        
	}

}
