//
//  Berliner_BadestellenApp.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 14.06.21.
//

import SwiftUI

@main
struct Berliner_BadestellenApp: App {    
    @State private var bathingAreas = BathingAreaJson.data
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
            Startview(bathingAreas: $bathingAreas)
            }
        }
    }
}
