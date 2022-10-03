//
//  ContentView.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 28.08.2022.
//

import SwiftUI
import RealmSwift
struct ContentView: View {
   @ObservedObject var viewModel: FileAirportViewModel
    @State private var searchText = ""
    @State private var selectionA: String? = nil
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                TextField("Enter a country and city", text: $searchText)
                switch viewModel.state{
                case .idle:
                    Color.clear.onAppear(perform: viewModel.getListAirportFile)
                case .loading:
                    ProgressView().padding()
                case .loaded(let Airports):
                    List(selection: $selectionA){
                        ForEach( Airports ,id: \.ID_ICAO ) { name in
                            NavigationLink(destination: METARView(airport: name,name: arrayMETAR.filter { $0.icao!.contains            (name.ID_ICAO)}) ) {
                   HStack{
                       ZStack (alignment: .center){
                           Circle().fill(name.color)
                                       .frame(width: 25, height: 25)
                       Image(name.weather).resizable()
                           .frame(width: 20.0, height: 20.0, alignment: .leading)
                           .clipShape(Circle())
                       }.padding(.leading, 5.0)
                        VStack(alignment: .leading){
                            Text(name.name).foregroundColor(.black)
                                    .font(.headline)
                                    .lineLimit(2)
                            Text(name.ID_ICAO).font(.system(size: 8)).foregroundColor(.gray)
                        }
                   }.frame(width: 300, height: 50, alignment: .leading)
                                    .background(.white)
                            }
                   .contextMenu {
                       Button(action: {if name.ID_ICAO == selectionA {deleteAirportsmacos()}}){
                       Text("Delete")
                       }
                    }
                            
                        }.onDelete(perform:deleteAirports)//on
                    }
                }
                NavigationLink{
                    if country != "" && city != "" {
                        addAirport(viewModel: ListAirportViewModel(country: country, city: city))
                    }
                }label: {Text("Add Airport")}.frame(width: 300,alignment: .center)
                }
        }.navigationTitle("Airports")
            .onAppear(perform: viewModel.restore)
                .frame(width: 800, height: 800, alignment: .leading)
    }//body
    func deleteAirports(at offsets: IndexSet){
        for i in 0...viewModel.arrayAirport.count-1{
            if offsets.contains(i){
                let arrayA =  Airport()
                arrayA.ID = viewModel.arrayAirport[i].ID
                arrayA.ID_ICAO = viewModel.arrayAirport[i].ID_ICAO
                arrayA.name = viewModel.arrayAirport[i].name
                arrayA.city = viewModel.arrayAirport[i].city
                deleteAirportFile(airport:  arrayA)
                print("delete " + selectionA!)
                viewModel.restore()
                break
            }
        }
        viewModel.arrayAirport.remove(atOffsets: offsets)
    }
    func deleteAirportsmacos(){
        for i in 0...viewModel.arrayAirport.count-1{
            if selectionA == viewModel.arrayAirport[i].ID_ICAO {
                let arrayA =  Airport()
                arrayA.ID = viewModel.arrayAirport[i].ID
                arrayA.ID_ICAO = viewModel.arrayAirport[i].ID_ICAO
                arrayA.name = viewModel.arrayAirport[i].name
                arrayA.city = viewModel.arrayAirport[i].city
                deleteAirportFile(airport:  arrayA )
                //viewModel.arrayAirport.remove(at: i )
                print("Delete " + selectionA!)
                //viewModel.restore()
                break
            }
        }
    }
    var city: String {
            if searchText.isEmpty{
                viewModel.reloadMETARTAF()
                return ("")
            }
            else{ if searchText.count > 3{
                return String(searchText.suffix(searchText.count - 3))}
                return ("")
            }
        }
    var country: String {
        if searchText.isEmpty{
            return ("")
        }
        else{ 
            if searchText.count > 2{
                makeCountryID()
            for i in 0...country_id.count-1 {
                if country_id[i] == searchText.prefix(2){
                   return country_id[i]
                }
            }
                searchText = ""}
            return  ""}
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: FileAirportViewModel())
    }
}

