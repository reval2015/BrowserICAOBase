
import Foundation
import SwiftUI
struct allDataA : Codable {
	let data : [DataA]?
	let results : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([DataA].self, forKey: .data)
		results = try values.decodeIfPresent(Int.self, forKey: .results)
	}

}
struct  sAirport {
    var ID = 0
    var ID_ICAO = ""
    var name = ""
    var city = ""
    var weather = ""
    var color: Color = .green
}
