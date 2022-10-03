//
//  Network.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 28.08.2022.
//

import Foundation
import Alamofire
import CoreLocation
import Accessibility
 
 

var arrayTAF: [TAF_Decoded] = []

func LoadNOTAM_Decode(ICAOCode: String){
    //arrayMETAR = []
let url = "https://notams.aim.faa.gov/notamSearch"
        let URL1: URL = URL(string: url)!
    let queryParameters: [String: Any] = [
     "reportType": "RAW",
      "method": "displayByICAOs",
      "actionType": "notamRetrievalByICAOs",
     "Email": "reval2007@gmail.com",
     "Password": "rikoshet@2022A",
      "retrieveLocId": ICAOCode]
        AF.request(URL1/*,parameters: queryParameters*/)//.validate()
        //.responseDecodable(of: TAFs.self)
        .responseString
    { responce in
         print( responce)
        /*   do {  let allData = try JSONDecoder().decode(TAFs.self, from: responce.data!)
          arrayTAF = allData.data ?? []
           print (arrayTAF.count )
           
                }catch{
                    print(error)
                }*/
        }
   
}
class ListAirportViewModel: ObservableObject {
    enum State {
            case idle
            case loading
            case failed
            case loaded([sAirport])
        }
   
    var city: String
    var country: String
    @Published private(set) var state = State.idle
var arrayAirport: [sAirport] = []
    init(country: String,city: String){
        self.country = country
        self.city = city
    }
func getListAirport( ){
lazy var geocoder = CLGeocoder()
    let address = "\(self.country), \(self.city)"
    self.state = .loading
    // Geocode Address String
    geocoder.geocodeAddressString(address) { (placemarks, error) in
        // Process Response
    if let error = error {
        print("Unable to Forward Geocode Address (\(error))")
        //locationLabel.text = "Unable to Find Location for Address"
        self.state = .failed 
    } else {
        var location: CLLocation?
        if let placemarks = placemarks, placemarks.count > 0 {
            location = placemarks.first?.location
        }
        if let location1 = location {
           let coordinate = location1.coordinate
           print (coordinate)
            self.arrayAirport = []
           let url =  urlCheckWX + "/station/lat/" + String(coordinate.latitude) + "/lon/" +  String(coordinate.longitude) + "/radius/30" + APIKey
                let URL1: URL = URL(string: url)!
                AF.request(URL1).validate()
                .responseDecodable(of: allDataA.self){ responce in
                    do {  let allData = try JSONDecoder().decode(allDataA.self, from: responce.data!)
                        let ind = allData.results!
                        var i1 = 0
                        if ind > 0 {
                            for i in 0...ind - 1{
                                if ((allData.data?[i].type!.contains("Airport")) == true){
                                    self.arrayAirport.append(sAirport())
                                    self.arrayAirport[i1].ID_ICAO = allData.data?[i].icao  ?? ""
                                    self.arrayAirport[i1].name = allData.data?[i].name ?? ""
                                    self.arrayAirport[i1].city = allData.data?[i].city ?? ""
                                    i1 = i1 + 1
                                }}
                        }
                        print("Airports is " + String(i1))
                        self.state =  .loaded(self.arrayAirport)
                        }catch{
                            print(error)
                        }
                }
            //return coordinate
           // locationLabel.text = "\(coordinate.latitude), \(coordinate.longitude)"
        } else {
            //locationLabel.text = "No Matching Location Found"
        }
    }
}
}
}
var arrayMETAR: [METAR_Data] = []
class FileAirportViewModel:  ObservableObject {
    enum State {
            case idle
            case loading
            case loaded([sAirport])
        }
     
    var arrayAirport: [sAirport]
    var setSemafor30min: Bool
    @Published private(set) var state = State.idle
    init(){
        self.state = State.idle
        self.arrayAirport  = []
        setSemafor30min = true
    }
    func restore(){self.state = State.idle
        self.setSemafor30min = true
    }
    func reloadMETARTAF(){
    let date = Date()
    let calendar = Calendar.current
    let minutes = calendar.component(.minute, from: date)
        if minutes == 30 || minutes == 0{
            self.restore()
            print(minutes)
        }
    }
func getListAirportFile() {
 let arrayA =  getAirportFile()
    self.arrayAirport = []
    let indF = arrayA.count
    if indF > 0 {
        self.state = .loading
        for i in 0...arrayA.count-1{
            self.arrayAirport.append(sAirport())
            self.arrayAirport[i].ID = i
            self.arrayAirport[i].ID_ICAO = arrayA[i].ID_ICAO
            self.arrayAirport[i].name = arrayA[i].name
            self.arrayAirport[i].city = arrayA[i].city
            self.arrayAirport[i].color = .red
            self.arrayAirport[i].weather = "sunny"
        }
        print("loadFile " + String(arrayA.count))
        if arrayMETAR.count  != indF || self.setSemafor30min {// set loadMetar every 30 min
            loadMETAR()
        }
    }
}
func loadMETAR() {
    var arrayICAO  = ""
    let ind = self.arrayAirport.count
    if ind > 0{
    for i in 0...ind - 1{
        if i == ind - 1{arrayICAO = arrayICAO + self.arrayAirport[i].ID_ICAO}
        else{arrayICAO = arrayICAO + self.arrayAirport [i].ID_ICAO + ","}
    }
        LoadMETAR_Decode(ICAOCode: arrayICAO)
        LoadTAF_Decode(ICAOCode: arrayICAO)
    }
}
func LoadMETAR_Decode(ICAOCode: String){
    arrayMETAR = []
    let url =  urlCheckWX + "/metar/" + ICAOCode + "/decoded" + APIKey
    let URL1: URL = URL(string: url)!
    AF.request(URL1).validate()
        .responseDecodable(of: Metar_Decoded.self){ responce in
            do {  let allData = try JSONDecoder().decode(Metar_Decoded.self, from: responce.data!)
               arrayMETAR = allData.data ?? []
               print ("loadMetar " + String(arrayMETAR.count) )
                self.setSemafor30min = false
                if arrayMETAR.count > 0{
                    var weather = "n_sunny"
                    let ind = arrayMETAR.count
                    if ind > 0{
                        for i1 in 0...ind-1 {
                            for i in 0...self.arrayAirport.count-1 {
                                if arrayMETAR[i1].icao == self.arrayAirport[i].ID_ICAO{
                                        let y = arrayMETAR[i1].clouds?.count ?? 0
                                        let y1 = arrayMETAR[i1].conditions?.count ?? 0
                                        if y1 > 0{
                                                weather = setWeather(name: arrayMETAR[i1], i: 0, z: 1)
                                        }
                                        else{if y > 0{weather = setWeather(name: arrayMETAR[i1], i: 0, z: 0)}}
                                        self.arrayAirport[i].color = .blue
                                        self.arrayAirport[i].weather = weather
                                        break
                                }
                        }}
                    }
                    self.state = .loaded(self.arrayAirport)
                }
            }catch{
                    print(error)
            }
    }
}
    func LoadTAF_Decode(ICAOCode: String){
        arrayTAF = []
    let url =  urlCheckWX + "/taf/" + ICAOCode + "/decoded" + APIKey
            let URL1: URL = URL(string: url)!
            AF.request(URL1).validate()
            .responseDecodable(of: TAFs.self){ responce in
                do {  let allData = try JSONDecoder().decode(TAFs.self, from: responce.data!)
              arrayTAF = allData.data ?? []
               print ("loadTAF " + String(arrayTAF.count) )
               
                    }catch{
                        print(error)
                    }
            }
       
    }
}
    
