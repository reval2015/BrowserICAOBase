//
//  addAirport.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 20.09.2022.
//

import SwiftUI

struct addAirport: View {
    @ObservedObject  var viewModel: ListAirportViewModel
    @State private var selection: String?
    var body: some View {
        VStack{
        Text("Select Airport")
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.getListAirport)
                
            case .failed:
                Text("Enter the correct country(only two simbol) and city")
            case .loaded(let listAiports):
            List(listAiports,id: \.ID_ICAO,selection: $selection) { name in
                //VStack{
                        HStack{
                            VStack{
                            Text(name.name).foregroundColor(.black)
                                    .font(.headline)
                                    .multilineTextAlignment(.leading)
                            //Text((name.city) )
                                Text(name.ID_ICAO).foregroundColor(.gray) 
                            }.frame(width: 110,  alignment: .leading)
                            Button {pressButton(arrayAirport: listAiports)
                            }label: {Image(systemName: "plus").background(Color(hue: 0.496, saturation: 0.071, brightness: 0.92)).foregroundColor(.black)}
                            
                        }.background(Color(hue: 0.496, saturation: 0.071, brightness: 0.92))
                    .frame(width: 160,  alignment: .leading)
                     
            }.frame(  alignment: .leading)
                 
            case  .loading:
                ProgressView()//.onAppear(perform: getListAirport1)
                    .padding()
            
            }
        
    }.frame(width: 200, height: 400, alignment: .leading)
}
    func pressButton(arrayAirport: [sAirport]){
       if selection != nil{
           print("Add " + selection!)
            if arrayAirport.count > 0{
            for i in 0...arrayAirport.count-1{
            if arrayAirport[i].ID_ICAO == selection{
                let arrayA =  Airport()
                arrayA.ID_ICAO = arrayAirport[i].ID_ICAO
                arrayA.name = arrayAirport[i].name
                arrayA.city = arrayAirport[i].city
                saveAirportFile(airport: arrayA)
                break
            }}
            }}
    }

}

struct addAirport_Previews: PreviewProvider {
    static var previews: some View {
        addAirport(viewModel: ListAirportViewModel(country: "UK",city: "London"))
    }
}

