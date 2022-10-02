import Foundation
struct Visibility : Codable {
	let meters : String?
	let meters_float : Int?
	let miles : String?
	let miles_float : Double?

	enum CodingKeys: String, CodingKey {

		case meters = "meters"
		case meters_float = "meters_float"
		case miles = "miles"
		case miles_float = "miles_float"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		meters = try values.decodeIfPresent(String.self, forKey: .meters)
		meters_float = try values.decodeIfPresent(Int.self, forKey: .meters_float)
		miles = try values.decodeIfPresent(String.self, forKey: .miles)
		miles_float = try values.decodeIfPresent(Double.self, forKey: .miles_float)
	}

}
