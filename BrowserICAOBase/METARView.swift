//
//  METARView.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 02.09.2022.
//

import SwiftUI

struct METARView: View {
    var airport: sAirport
    var name: [METAR_Data]
    @State private var offset = CGPoint.zero
    var body: some View {
        if name.count > 0{
        VStack{
            GroupBox(
                        label: Label(" ", systemImage: "airplane.circle")
            ){
                VStack(alignment: .center){
                    ZStack (alignment: .center){
                                Circle().fill(airport.color)
                                    .frame(width:220, height: 220)
                    Image(airport.weather).resizable()
                        .frame(width: 100.0, height: 100.0, alignment: .center)
                        //.clipShape(Circle())
                    }.padding(.leading, 5.0)
                    Text(airport.name).font(.system(size: 20))
                    Text(airport.ID_ICAO).font(.system(size: 12))
                }.frame(width: 300.0,   alignment: .center)
            }
            .background(airport.color)
                .cornerRadius(10)
            GroupBox(
                    label: Label(" ", systemImage: "airplane.circle.fill")
                            .foregroundColor(.blue)
            ){
            HStack{
                    VStack{
            if name[0].flight_category!  == "VFR"{
             Text(name[0].flight_category! ).foregroundColor(.green)
            }else{if name[0].flight_category!  == "MVFR"{
             Text(name[0].flight_category! ).foregroundColor(.blue)
            }else{if name[0].flight_category!  == "IFR"{
                Text(name[0].flight_category! ).foregroundColor(.red)
            }else{if name[0].flight_category!  == "LIFR"{
                Text(name[0].flight_category! ).foregroundColor(.orange)
            }else{Text("VFR" ).foregroundColor(.green)}
            }}}
                if name[0].raw_text!.contains("WS"){
                    Text("Wind Shear").foregroundColor(.red)}
            }
            
            let Temper = String((name[0].temperature?.celsius!)!) + " °C"
             Label(Temper, systemImage: "thermometer.sun").font(.system(size: 14)).foregroundColor(.black)
                             
            }
                HStack{
                        let y = name[0].clouds?.count ?? 0
                         let y1 = name[0].conditions?.count ?? 0
                        
                        if y > 0 {
            VStack{
            Image(setWeather(name: name[0], i: 0,z: 0)).resizable()
                .frame(width: 25.0, height: 25.0, alignment: .leading)
               if (name[0].clouds?[0].meters ?? 0) > 0 {
                Text(name[0].clouds![0].text!).foregroundColor(.black)
               }}
            if y > 1 {
                VStack{
        Image(setWeather(name: name[0], i: 1,z: 0)).resizable()
                    .frame(width: 25.0, height: 25.0, alignment: .leading)
                if (name[0].clouds?[1].meters ?? 0) > 0 {
                 Text(name[0].clouds![1].text!).foregroundColor(.black)
                }}}
            if y == 3{
            VStack{
        Image(setWeather(name: name[0], i: 2,z: 0)).resizable()
                        .frame(width: 25.0, height: 25.0, alignment: .leading)
                    if (name[0].clouds?[2].meters ?? 0) > 0 {
                     Text(name[0].clouds![2].text!).foregroundColor(.black)
                    }}}
        }
        if y1 > 0 {
            VStack{
        Image(setWeather(name: name[0], i: 0,z: 1)).resizable()
                .frame(width: 25.0, height: 25.0, alignment: .leading)
                Text(name[0].conditions![0].text!).foregroundColor(.black)}
            if y1 > 1 {
                VStack{
        Image(setWeather(name: name[0], i: 1,z: 1)).resizable()
                    .frame(width: 25.0, height: 25.0, alignment: .leading)
                    Text(name[0].conditions![1].text!).foregroundColor(.black)}
                if y1 > 2 {
                    VStack{
                    Image(setWeather(name: name[0], i: 2,z: 1)).resizable()
                        .frame(width: 25.0, height: 25.0, alignment: .leading)
                        Text(name[0].conditions![2].text!).foregroundColor(.black)}
        }}}
                if name[0].raw_text!.contains("NSW")
                {Text("NSW").foregroundColor(.black) }
                }
                HStack{
                Label(" ", systemImage: "wind").foregroundColor(.blue)
                    if !name[0].raw_text!.contains("00KT"){
                if !name[0].raw_text!.contains("VRB"){
            Text(" " + String(name[0].wind?.degrees! ?? 0) + "°   ") .foregroundColor(.black)
            if name[0].raw_text!.contains("0V"){
                Text(Angle1_2(name: name[0])).foregroundColor(.black)}}
                else {Text("Var").foregroundColor(.black)}
            let Wind = Velosity_Wind(name: name[0])
             Text("  " + Wind/*, systemImage: "wind"*/).foregroundColor(.black)
                            .font(.system(size: 12))

                if  search_GKT(name: name[0]){
                        Image(systemName:"wind").foregroundColor(.black)
                }
                }
                    else{Text(" NONE ").foregroundColor(.black)}
            }
            HStack{
                Text("Cloudbase:").fontWeight(.light).foregroundColor(.black)
                let claudbase = String(name[0].clouds?[0].meters ?? 0) + "m"
                Text(claudbase/*, systemImage: "wind"*/)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                                .font(.system(size: 12))
            Text("Visibility:").fontWeight(.light).foregroundColor(.black)
            let Visibility = String(name[0].visibility!.meters!) + "m"
            Text(Visibility/*, systemImage: "wind"*/).fontWeight(.heavy) .foregroundColor(.black)
                            .font(.system(size: 12))
             }
        }.frame(width: 300.0,   alignment: .leading)
            .background(.white)
                .cornerRadius(10)
        
        }
        HStack{
            Text(name[0].raw_text!).foregroundColor(.black)
        }.frame(width: 300.0,   alignment: .leading)
        .background(Color(hue: 0.683, saturation: 0.291, brightness: 0.731))
            HStack {
                VStack {
            ScrollView([.vertical]) {
                                rowsHeader.offset(y: offset.y)
                            }.disabled(true)
                }
            ScrollView(.horizontal,showsIndicators: true) {
                VStack{
                    HStack(spacing: 15) {
                        ForEach(CreateTAFTable(TAF: arrayTAF[airport.ID] ),id: \.id) { TAFT in
                            TARView(name: TAFT)
                        }
                    }.padding(.top, 10)
                }}.frame(width: 230.0, height: 180)
            }.frame(width: 300.0,height: 180,alignment: .leading)
            ScrollView(.vertical,showsIndicators: true){
                VStack(alignment: .leading) {
                    ForEach(Raw_KR(name: arrayTAF[airport.ID]), id: \.id){ TAF_RAW in
                        Text(TAF_RAW.Stroka).foregroundColor(.black)
                    }}}.frame(width: 300.0, height: 100,  alignment: .leading)
                .background(Color(hue: 0.683, saturation: 0.291, brightness: 0.731))
            }
    }
    var rowsHeader: some View {
            VStack(alignment: .leading, spacing:  0) {
                ForEach(makeColumn0(),id: \.id) { row in
                    if row.id == 1 || row.id == 2 {   Text(row.text)
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))
                            .frame(width: 70, height: 40)
                            //.border(Color.blue)
                    }
                    else{
                    Text(row.text)
                        .foregroundColor(.secondary)
                        .font(.system(size: 12))
                        .frame(width: 70, height: 15)
                        //.border(Color.blue)
                    }
                }
            }
        }
}
struct METARView_Previews: PreviewProvider {
    static var previews: some View {
        METARView(airport: sAirport(),name: arrayMETAR)
    }
}
