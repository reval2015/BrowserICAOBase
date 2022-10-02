//
//  ContentView.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 28.08.2022.
//

import SwiftUI
// review base of ICAO Code Load from Internet or File
struct ContentView: View {
  
    @State private var searchText = ""
    var body: some View {
        VStack{
        NavigationView {
            List {
                    ForEach(searchResults,id: \.ident) { name in
                            HStack{
                                    Text(name.municipality)
                                    .font(.headline)
                                    Text(name.name)
                                    Text(name.ident)
                            }
                    }
            }
            .searchable(text: $searchText)
            .navigationTitle("Browser ICAO Code base")
        }
       Text(String(arrayICAOCode.count))
        
        }
    
    }
    var searchResults: [BaseICAOCodeL] {
                if searchText.isEmpty {
                    if((arrayName).isEmpty
                    ){LoadBase() }
                    return arrayName
                } else {
                    return arrayName.filter { $0.municipality.contains(searchText) }
                }
            }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
