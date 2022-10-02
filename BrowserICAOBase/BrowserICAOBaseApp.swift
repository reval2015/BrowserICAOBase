//
//  BrowserICAOBaseApp.swift
//  BrowserICAOBase
//
//  Created by Valentyn Reshetniak on 28.08.2022.
//

import SwiftUI

@main
struct BrowserICAOBaseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: FileAirportViewModel())
        }
    }
}
