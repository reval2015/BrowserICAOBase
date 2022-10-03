//
//  Constants.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 31.08.2022.
//

import Foundation
var country_id: [String] = []

func makeCountryID() {
    var country_codes: String = "AD AE AF AG AI AL AM AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BJ BL BM BN BO BQ BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN  CO CR CU CV CW CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM  IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA  NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RE RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR SS ST SV SX SY SZ TC TD TF  TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW "
    let y = country_codes.count/3
    let y1 = country_codes.count
    country_id = []
    for i in 1 ... y {
        country_id.append(String(country_codes.prefix(2)))
        var i1 = 1
        while country_id[i-1].contains(" ")  {country_codes = String(country_codes.suffix(y1 - (i-1)*3 - i1))
            country_id[i-1] = (String(country_codes.prefix(2)))
            i1 = i1 + 1
        }
        country_codes = String(country_codes.suffix(y1 - i*3))
    }
  }
let urlCheckWX = "https://api.checkwx.com"

struct Column {
    let id: Int
    let text: String
}
 
func makeColumn0()-> [Column]{
    var col: [Column] = []
    let rowName: [String]
    = ["Date,time","Clouds","Weather","Visibility","Ceiling","Wind","Wind speed","Gust speed"]
        for i in 0...rowName.count-1{
            col.append(Column(id: i, text: rowName[i]))
    }
    return col
}
