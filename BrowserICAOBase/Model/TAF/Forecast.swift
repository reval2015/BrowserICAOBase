import Foundation
struct Forecast : Codable {
    let ceiling: Ceiling?
	let clouds : [Clouds]?
	let conditions : [Conditions]?
	let timestamp : Timestamp?
	let visibility : Visibility?
	let wind : Wind?

	enum CodingKeys: String, CodingKey {
        case ceiling = "ceiling"
		case clouds = "clouds"
		case conditions = "conditions"
		case timestamp = "timestamp"
		case visibility = "visibility"
		case wind = "wind"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        ceiling = try values.decodeIfPresent(Ceiling.self, forKey: .ceiling)
        clouds = try values.decodeIfPresent([Clouds].self, forKey: .clouds)
		conditions = try values.decodeIfPresent([Conditions].self, forKey: .conditions)
		timestamp = try values.decodeIfPresent(Timestamp.self, forKey: .timestamp)
		visibility = try values.decodeIfPresent(Visibility.self, forKey: .visibility)
		wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
	}

}
