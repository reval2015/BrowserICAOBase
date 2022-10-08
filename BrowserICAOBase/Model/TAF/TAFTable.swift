//
//  TAFTable.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 05.09.2022.
//

import Foundation
struct TAFTable {
    var id: Int = 0
    var date1: Int = 0
    var time1: Int = 0
    var clouds_code: String = ""
    var conditions_code: String = ""
    var ceiling: String = ""
    var visibility: String = ""
    var wind: String = ""
    var speed_kts: Int = 0
    var gust_kts: String = ""
}
var TAFTableV0:  [TAFTable] = []
var TAFTableV1:  [TAFTable] = []
func CreateTAFTable(TAF: TAF_Decoded)-> [TAFTable]  {
    var TAFTableV: [TAFTable] = []
    var time1: Int = 0
    time1 = Int((TAF.timestamp!.from!.prefix(13)).suffix(2))!
    var date = Int((TAF.timestamp!.from!.prefix(10)).suffix(2))!
    let date1 = Int((TAF.timestamp!.to!.prefix(10)).suffix(2))!
    if time1 > 23 {time1 = time1 - 24; date = date + 1;if date1 < date {date = 1}}
    var y = 0
    for i in 0 ... 29 {
        TAFTableV.append(TAFTable(id: i,date1: date,time1: time1 , clouds_code: "NSC",conditions_code: "NSW", ceiling: "",
                                  visibility:   "" , wind:  "o", speed_kts:  0 , gust_kts: "" ))
        time1 = time1 + 1
        if time1 == 24 {
            time1 = 0
            date = date + 1
            if date1 < date {date = 1}
        }
    }
    //y = y + 1
    time1 = Int((TAF.forecast![y].timestamp!.from!.prefix(13)).suffix(2))!
    date = Int((TAF.forecast![y].timestamp!.from!.prefix(10)).suffix(2))!
    var i = 0
    while i < 30 { if TAFTableV[i].time1 == time1 &&  TAFTableV[i].date1 == date{
        if TAF.forecast?[y].clouds!.count ?? 0  > 0 { TAFTableV[i].clouds_code = (TAF.forecast?[y].clouds?[0].code) ?? "NSC"}
        var ceilingS = ""
        if ((TAF.forecast?[y].ceiling?.meters) ?? 0) > 0 {ceilingS = String((TAF.forecast?[y].ceiling?.meters) ?? 0) }
        if ceilingS == "" {if TAF.forecast?[y].clouds!.count ?? 0  > 0 {if ((TAF.forecast?[y].clouds?[0].meters) ?? 0) > 0 {
            ceilingS = String((TAF.forecast?[y].clouds?[0].meters) ?? 0) }}}
        if  ceilingS != "" {TAFTableV[i].ceiling = ceilingS}
        if (TAF.forecast?[y].visibility?.meters) ?? "" != "" {TAFTableV[i].visibility = (TAF.forecast?[y].visibility?.meters) ?? ""}
        if (TAF.forecast?[y].conditions?[0].code) ?? "NSW" != "NSW" {TAFTableV[i].conditions_code =  (TAF.forecast?[y].conditions?[0].code) ?? "NSW"}
        if TAF.forecast?[y].wind?.degrees ?? 0 > 0 {
            if TAF.forecast?[y].wind?.degrees ?? 0 == 0 {
                if TAFTableV[i].wind == "o"{
                TAFTableV[i].wind  = TAFTableV[i-1].wind
                TAFTableV[i].speed_kts = TAFTableV[i-1].speed_kts
                }}
            else{
                TAFTableV[i].wind = String((TAF.forecast?[y].wind?.degrees) ?? 0) + "°"
                TAFTableV[i].speed_kts = (TAF.forecast?[y].wind?.speed_kts) ?? 0
            }
            var gustS = ""
            if TAFTableV[i].gust_kts == ""{
            if ((TAF.forecast?[y].wind?.gust_kts) ?? 0) > 0 {gustS = String((TAF.forecast?[y].wind?.gust_kts) ?? 0) + "kt"}
            TAFTableV[i].gust_kts = gustS
            }
        }
        time1 = time1 + 1
        }
        i = i + 1
        if time1 == 24 {time1 = 0
            date = date + 1
            if date1 < date {date = 1}
        }
        if time1 == Int((TAF.forecast![y].timestamp!.to!.prefix(13)).suffix(2))! && date == Int((TAF.forecast![y].timestamp!.to!.prefix(10)).suffix(2))!{
            y = y + 1
            i = 0
            if TAF.forecast!.count > y {
            time1 = Int((TAF.forecast![y].timestamp!.from!.prefix(13)).suffix(2))!
            date = Int((TAF.forecast![y].timestamp!.from!.prefix(10)).suffix(2))!
            }else {break}
        }
    }
    return TAFTableV
}
