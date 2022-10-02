import Foundation
struct TAFs: Decodable {
    let data : [TAF_Decoded]?
    let results : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case results = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([TAF_Decoded].self, forKey: .data)
        results = try values.decodeIfPresent(Int.self, forKey: .results)
    }

}
