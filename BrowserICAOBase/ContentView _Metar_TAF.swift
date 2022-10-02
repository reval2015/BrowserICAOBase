//
//  ContentView.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 28.08.2022.
//

import SwiftUI
// search 
struct ContentView: View {
    @State private var searchText = ""
    @State private var i = 0
    var body: some View {
        //VStack(alignment: .leading){
        VStack{
        NavigationView {
            List {
                ForEach(searchResults,id: \.icao) { name in
                    VStack{
                            HStack{
                                Text((name.station?.name!)! + ",")
                                    .font(.headline)
                                Text((name.station?.location!)! + ",")
                                    Text(name.icao!)
                            }
                            METARView(name: name)
                        VStack(spacing: 15) {
                            if name.icao == "EDDF" {let TAFT1 = arrayTAF[0]
                                ScrollView(.horizontal,showsIndicators: true) {
                                    VStack{
                                        HStack(spacing: 15) {
                                            ForEach(CreateTAFTable(TAF: arrayTAF[0] ),id: \.id) { TAFT in
                                                TARView(name: TAFT)
                                            }
                                        }.padding(.top, 10)
                                    }
                                }.frame(height: 180)
                                ScrollView(.vertical,showsIndicators: true){
                                    VStack(alignment: .leading) {
                                        ForEach(Raw_KR(name: TAFT1), id: \.id){ TAF_RAW in
                                            Text(TAF_RAW.Stroka)
                                        }                     } }                 }
                            if name.icao == "LEMD" {let TAFT1 = arrayTAF[1]
                                ScrollView(.horizontal,showsIndicators: true) {
                                    VStack{
                                        HStack(spacing: 15) {
                                            ForEach(CreateTAFTable(TAF: arrayTAF[1] ),id: \.id) { TAFT in
                                                TARView(name: TAFT)
                                            }
                                        }.padding(.top, 10)
                                    }}.frame(height: 180)
                                ScrollView(.vertical,showsIndicators: true){
                                    VStack(alignment: .leading) {
                                        ForEach(Raw_KR(name: TAFT1), id: \.id){ TAF_RAW in
                                            Text(TAF_RAW.Stroka)
                                        }}}}
                                
                        }.padding(.top, 10)
                        .padding(.bottom, 20)
                }
            }.searchable(text: $searchText)
            .navigationTitle("METAR airports")
        }
            Text(String(arrayMETAR.count))
        }
    }
    }
    var searchResults: [METAR_Data] {
                if searchText.isEmpty {
                    LoadMETARTAF()
                    return arrayMETAR
                } else {
                    return arrayMETAR.filter { $0.station!.name!.contains(searchText) }
                }
            }
    var sr2: [TAF_Decoded] {
                if searchText.isEmpty{
                    return arrayTAF
                } else {
                    return arrayTAF.filter { $0.station!.name!.contains(searchText) }
                }
            }
     
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
