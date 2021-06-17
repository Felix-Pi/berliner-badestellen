//
//  MapView.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 14.06.21.
//
import MapKit
import SwiftUI

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct Marker: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    let bathingArea: BathingArea
    
    var body: some View {
        let annotations = [
            Marker(name: bathingArea.badname, coordinate: CLLocationCoordinate2D(latitude: bathingArea.longitude, longitude: bathingArea.latitude)),
        ]

        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: bathingArea.longitude, longitude: bathingArea.latitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))), annotationItems: annotations) {
            MapPin(coordinate: $0.coordinate)
        }
        .navigationTitle("Map")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: NavigationLink(destination: DetailView(bathingArea: bathingArea)) {
                Label(bathingArea.badname, systemImage: "chevron.backward")
            }
            
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
           .ignoresSafeArea()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(bathingArea: BathingArea.data[0])
    }
}
