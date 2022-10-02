//
//  DataManager.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 05.08.2022.
//

import Foundation
import RealmSwift
import SwiftUI
class  Airport: Object{
    @Persisted  var ID = 0
    @Persisted  var ID_ICAO = ""
    @Persisted  var name = ""
    @Persisted  var city = ""
}
struct DataManager {
   let realm1 = try? Realm()
    // Save into Base
    func save(airport: Airport){
        var array = [Airport]()
        guard let Record = realm1?.objects(Airport.self)
        else {
            try! realm1?.write {
                airport.ID = 1
            realm1?.add(airport)
            }
            return
        }
        for i in Record {
            array.append(i)
        }
        if array.count > 0{
            for j in 0 ... array.count-1{
                if airport.ID   == array[j].ID  {
                    try! realm1?.write {
                        airport.ID   = array[j].ID
                    }
                return
                }
            }
        }
        try! realm1?.write {
            if array.count > 0{airport.ID = array[array.count-1].ID + 1}else{airport.ID = 1}
            realm1?.add(airport)
        }
    }
   // Get list of the records in Base
    func getList() -> [Airport]{
        var array = [Airport]()
        guard let Record = realm1?.objects(Airport.self) else { 
            do {
                // Delete the realm if a migration would be required, instead of migrating it.
                // While it's useful during development, do not leave this set to `true` in a production app!
                let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: false)
                let realm1 = try Realm(configuration: configuration)
                _ = try Realm.deleteFiles(for: configuration)
          } catch {
                print("Error opening realm: \(error.localizedDescription)")
            }
            return []}
         for i in Record {
            array.append(i)
        }
        return array
    }
    func delete(airport: Airport){
        try! realm1?.write {
            //let predicate = NSPredicate(format: "ID = %@", airport.ID)
            if let productToDelete = realm1?.objects(Airport.self).filter("ID_ICAO = %@", airport.ID_ICAO) {
                  realm1?.delete(productToDelete)
            }
                //realm1?.delete(airport)
        }
    }
}
