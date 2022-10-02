//
//  Function.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 01.09.2022.
//

import Foundation
func setWeather(name: METAR_Data, i: Int,z: Int)-> String{
var ImageS: String = ""
var codeS: String = ""
if z == 0 {codeS = (name.clouds?[i].code!)!}
if z > 0 { codeS = name.conditions![i].code!}
if !codeS.isEmpty {
switch (codeS) {
case "BKN":
if (Int((name.observed!.prefix(13)).suffix(2))! > 6) && (Int((name.observed!.prefix(13)).suffix(2))! < 18){ ImageS = ("broken")}
else{ImageS = ("n-broken")}
    break
case "CLR":
if (Int((name.observed!.prefix(13)).suffix(2))! > 6) && (Int((name.observed!.prefix(13)).suffix(2))! < 18){ ImageS = ("sunny")}
else{ImageS  = ("n-sunny")}
    break
case "FEW":
if (Int((name.observed!.prefix(13)).suffix(2))! > 6) && (Int((name.observed!.prefix(13)).suffix(2))! < 18){ ImageS  = ("few")}
else{ImageS  = ("n-few")}
    break
case "OVC":
 ImageS  = ("overcast")
    break
case "BCFG":
 ImageS = ("fog")
    break
case "BR":
 ImageS = ("n-mist")
    if (Int((name.observed!.prefix(13)).suffix(2))! > 6) && (Int((name.observed!.prefix(13)).suffix(2))! < 18){ ImageS = ("mist")}
    break
case "DZ":
 ImageS = ("light-rain")
    break
case "RA":
 ImageS = ("rain")
    if z == 1 {if name.conditions![i].prefix == "-" {ImageS = ("light-rain")}}
    break
case "SCT":
if (Int((name.observed!.prefix(13)).suffix(2))! > 6) && (Int((name.observed!.prefix(13)).suffix(2))! < 18){ ImageS = ("scattered")}
else{ImageS = ("n-scattered")}
    break
case "SH":
 ImageS = ("rain")//shower
    if z == 1 {if name.conditions![i].prefix == "-" {ImageS = ("light-rain")}}
    break
case "GR":
 ImageS = ("hail")
    break
case "TS":
 ImageS = ("thunder")
    break
case "TSRA":
 ImageS = ("thunder")
    if z == 1 {if name.conditions![i].prefix == "+"{ImageS = ("heavy-thunder")}}
    break
 
default:
    if (Int((name.observed!.prefix(13)).suffix(2))! > 6) && (Int((name.observed!.prefix(13)).suffix(2))! < 18){ImageS = ("sunny")}
    else{ImageS  = ("n-sunny")}
    break
}
}
    return ImageS
}
func setWeatherTAF(name: TAFTable, i: Int)-> String{
var ImageS: String = ""
var codeS: String = ""
if i == 1 {codeS = (name.clouds_code)}
if i == 2 {codeS = (name.conditions_code)}
if !codeS.isEmpty {
switch (codeS) {
case "BKN":
if (name.time1 > 6) && (name.time1 < 18){ ImageS = ("broken")}
else{ImageS = ("n-broken")}
    break
case "CLR":
if (name.time1 > 6) && (name.time1 < 18){ ImageS = ("sunny")}
else{ImageS  = ("n-sunny")}
    break
case "FEW":
if (name.time1 > 6) && (name.time1 < 18){ ImageS  = ("few")}
else{ImageS  = ("n-few")}
    break
case "OVC":
 ImageS  = ("overcast")
    break
case "BCFG":
 ImageS = ("fog")
    break
case "BR":
 ImageS = ("n-mist")
    if (name.time1 > 6) && (name.time1 < 18){ ImageS = ("mist")}
    break
case "DZ":
 ImageS = ("light-rain")
    break
case "RA":
 ImageS = ("rain")
    if i == 2 {if name.conditions_code.prefix(1) == "-" {ImageS = ("light-rain")}}
    break
case "SCT":
if (name.time1 > 6) && (name.time1 < 18){ ImageS = ("scattered")}
else{ImageS = ("n-scattered")}
    break
case "SH":
 ImageS = ("rain")//shower
    if i == 2 {if name.conditions_code.prefix(1) == "-" {ImageS = ("light-rain")}}
    break
case "GR":
 ImageS = ("hail")
    break
case "TS":
 ImageS = ("thunder")
    break
case "TSRA":
 ImageS = ("thunder")
    if i == 2 {if name.conditions_code.prefix(1) == "+"{ImageS = ("heavy-thunder")}}
    break
default:
    if i == 1{
    if (name.time1 > 6) && (name.time1 < 18){ImageS = ("sunny")}
        else{ImageS  = ("n-sunny")}}
    else{
        ImageS  = ("NULL")
    }
    break
}}
    return ImageS
}
func LoadMETARTAF(){
let date = Date()
let calendar = Calendar.current
let minutes = calendar.component(.minute, from: date)
 /*
            if((arrayMETAR).isEmpty) { LoadMETAR_Decode(ICAOCode: "EDDF,LEMD")
                LoadTAF_Decode(ICAOCode: "EDDF,LEMD")
                //LoadNOTAM_Decode(ICAOCode: "EDDF,LEMD")
                //TAFTableV0 = CreateTAFTable(TAF: arrayTAF[0] )
                //TAFTableV1 =  CreateTAFTable(TAF: arrayTAF[1] )
            }
            else{
                if minutes > 21 && minutes < 29 {
                    LoadMETAR_Decode(ICAOCode: "EDDF,LEMD")
                    LoadTAF_Decode(ICAOCode: "EDDF,LEMD")
                    
                }else{
                    if minutes > 51 && minutes < 59 {
                        LoadMETAR_Decode(ICAOCode: "EDDF,LEMD")
                        LoadTAF_Decode(ICAOCode: "EDDF,LEMD")
                        
                    }
                }
}*/
}
func Angle1_2(name: METAR_Data) -> String{
    var angl1 = ""
    let text = Array(name.raw_text!)
    for i in 0 ... name.raw_text!.count - 1{
        if String(text[i..<i+2]) == "0V"{
            angl1 = String(text[i-2..<i+1]) + "°..." + String(text[i+2..<i+5]) + "°"
            break
        }
    }
    return angl1
}
func search_GKT(name: METAR_Data)-> Bool{
    let text = Array(name.raw_text!)
    for i in 0 ... name.raw_text!.count - 5{
        if String(text[i..<i+1]) == "G"{
            if String(text[i+2..<i+4]) == "KT"{
            return true
            }
            if String(text[i+3..<i+5]) == "KT"{
            return true
            }
        }
    }
        return false
}
func Velosity_Wind(name: METAR_Data)->String{
    var Wind = ""
    Wind = Wind + String(name.wind!.speed_kts!)
    if name.wind?.gust_kts ?? 0 != 0
    { Wind = Wind + "-" + String(name.wind!.gust_kts!) }
    Wind = Wind  + "kt "
    return Wind
}
struct TAF_RAW_text{
    var id  = 0
    var Stroka = ""
}
func Raw_KR(name: TAF_Decoded)->[TAF_RAW_text]{
    var arrayInd: [Int] = []
    var Text_RAW: [TAF_RAW_text]  = []
    let text = Array(name.raw_text!)
    arrayInd.append(Int(0))
    for i in 0...name.raw_text!.count - 4{
        if String(text[i..<i+4]) == "PROB"{arrayInd.append(Int(i))}
        if String(text[i..<i+3]) == "BEC"{arrayInd.append(Int(i))}
    }
    arrayInd.append(Int(name.raw_text!.count))
    if arrayInd.count > 0 {
        for i in 0...arrayInd.count - 2{
            Text_RAW.append(TAF_RAW_text(id: i,Stroka: String(text[arrayInd[i]..<arrayInd[i+1]])))
        }
    }
    else{Text_RAW.append(TAF_RAW_text(id: 0,Stroka: name.raw_text!))}
    return Text_RAW
}

let DM = DataManager()
func saveAirportFile(airport: Airport){
     DM.save (airport: airport)
 }
func deleteAirportFile(airport: Airport){
     DM.delete(airport: airport)
 }
func getAirportFile()->[Airport]{
    return DM.getList()
}
