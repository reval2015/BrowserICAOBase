

import Foundation
struct BaseICAOCode : Decodable {
    let continent : String?
    let coordinates : String?
    let elevation_ft : String?
    let gps_code : String?
    let iata_code : String?
    let ident : String?
    let iso_country : String?
    let iso_region : String?
    let local_code : String?
    let municipality : String?
    let name : String?
    let type : String?



	enum CodingKeys: String, CodingKey {

		case continent = "continent"
		case coordinates = "coordinates"
		case elevation_ft = "elevation_ft"
		case gps_code = "gps_code"
		case iata_code = "iata_code"
		case ident = "ident"
		case iso_country = "iso_country"
		case iso_region = "iso_region"
		case local_code = "local_code"
		case municipality = "municipality"
		case name = "name"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		continent = try values.decodeIfPresent(String.self, forKey: .continent)
		coordinates = try values.decodeIfPresent(String.self, forKey: .coordinates)
		elevation_ft = try values.decodeIfPresent(String.self, forKey: .elevation_ft)
		gps_code = try values.decodeIfPresent(String.self, forKey: .gps_code)
		iata_code = try values.decodeIfPresent(String.self, forKey: .iata_code)
		ident = try values.decodeIfPresent(String.self, forKey: .ident)
		iso_country = try values.decodeIfPresent(String.self, forKey: .iso_country)
		iso_region = try values.decodeIfPresent(String.self, forKey: .iso_region)
		local_code = try values.decodeIfPresent(String.self, forKey: .local_code)
		municipality = try values.decodeIfPresent(String.self, forKey: .municipality)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}

