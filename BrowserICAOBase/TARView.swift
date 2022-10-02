//
//  TARView.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 02.09.2022.
//

import SwiftUI

struct TARView: View {
    var name: TAFTable
    var body: some View {
        VStack{
            Text(String(name.date1) + "/" + String(name.time1))
            Image(setWeatherTAF(name: name,i: 1)).resizable()
                .frame(width: 25.0, height: 25.0, alignment: .leading)
            Image(setWeatherTAF(name: name,i: 2)).resizable()
                .frame(width: 25.0, height: 25.0, alignment: .leading)
            Text(name.visibility)
            Text(String(name.ceiling))
            Text(String(name.wind))
            Text(String(name.speed_kts) + "kt")
            Text(String(name.gust_kts))
        }
    }
}
struct TARView_Previews: PreviewProvider {
    static var previews: some View {
        TARView(name: TAFTableV0[0])
    }
}
