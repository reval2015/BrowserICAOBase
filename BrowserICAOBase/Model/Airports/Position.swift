import Foundation
struct Position : Codable {
	let base : Base?
	let bearing : Bearing?
	let meters : Double?
	let miles : Double?
	let orientation : Orientation?

	enum CodingKeys: String, CodingKey {

		case base = "base"
		case bearing = "bearing"
		case meters = "meters"
		case miles = "miles"
		case orientation = "orientation"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		base = try values.decodeIfPresent(Base.self, forKey: .base)
		bearing = try values.decodeIfPresent(Bearing.self, forKey: .bearing)
		meters = try values.decodeIfPresent(Double.self, forKey: .meters)
		miles = try values.decodeIfPresent(Double.self, forKey: .miles)
		orientation = try values.decodeIfPresent(Orientation.self, forKey: .orientation)
	}

}
