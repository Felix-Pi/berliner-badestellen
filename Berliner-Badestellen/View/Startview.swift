//
//  Startview.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 14.06.21.
//

import SwiftUI


struct Startview: View {
    @Binding var bathingAreas: [BathingArea]
    
    var body: some View {
        List() {
            ForEach(bathingAreas, id: \.id) { bathingArea in
                NavigationLink(destination: DetailView(bathingArea: bathingArea)) {
                    BathingAreaRow(bathingArea: bathingArea)
                }
                .navigationBarTitle("Badestellen", displayMode: .inline)
            }
            
            Section(header: Text("Alle Badestellen Berlins")) {
                MapView.view_small(bathingArea: BathingArea(properties: PropertiesData.empty, coords: Coords(coordinates: [13.400,52.5067614])), annotations: Marker.getMarkers(bathingAreas: bathingAreas), zoom: 0.6)
                    .frame(height: 300)
            }
            
            Section(header: Text("Erklärungen")) {
                HelpView()
            }
        }
        .navigationBarItems(
            trailing:
                HStack {
                    Menu() {
                        Text("Bedestellen Sortieren nach")
                        
                        Button(action: { bathingAreas.sort { $0.temp > $1.temp } }) {
                            Label("Temperatur", systemImage: "arrow.down")
                        }
                        Button(action: { bathingAreas.sort { $0.quality.rawValue > $1.quality.rawValue } }) {
                            Label("Qualität", systemImage: "arrow.down")
                        }
                        Button(action: { bathingAreas.sort { $0.badname < $1.badname } }) {
                            Label("Badname", systemImage: "arrow.up")
                        }
                        Button(action: { bathingAreas.sort { $0.bezirk < $1.bezirk } }) {
                            Label("Bezirk", systemImage: "arrow.up")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    
                    Button(action: { bathingAreas.reverse() }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
        )
    }
    
}

struct Startview_Previews: PreviewProvider {
    static var previews: some View {
        Startview(bathingAreas: .constant(BathingArea.data))
    }
}
