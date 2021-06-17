//
//  MapView.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 17.06.21.
//

import Foundation
import SwiftUI
import MapKit

final class Marker: NSObject, MKAnnotation {
    let title: String?
    let latitude : Double
    let longitude : Double
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, latitude: Double, longitude : Double) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate =  CLLocationCoordinate2D(latitude: longitude, longitude: latitude)
    }
    
    static func getMarkers(bathingAreas : [BathingArea]) -> [Marker] {
        var annotations : [Marker] = []
        for bathingArea in bathingAreas {
            let marker : Marker = Marker(title: bathingArea.badname, latitude: bathingArea.latitude, longitude: bathingArea.longitude)
            annotations.append(marker)
        }
        
        return annotations
    }
    
    static func getMarker(bathingArea : BathingArea) -> [Marker] {
        return [Marker(title: bathingArea.badname, latitude: bathingArea.latitude, longitude: bathingArea.longitude)]
    }
}


struct MapView: UIViewRepresentable {
    let bathingArea: BathingArea
    @Binding var annotations : [Marker]
    var zoom : Double = 0.05
    
    var locationManager = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        //location request
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: bathingArea.longitude, longitude: bathingArea.latitude), span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)), animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
    }
    
    struct view: View {
        @State var bathingArea: BathingArea
        @State var annotations : [Marker]
        @State var zoom : Double = 0.05
        
        @State private var includeAllMarkers = false
                
        var body: some View {
            MapView(bathingArea: bathingArea, annotations: $annotations, zoom: zoom)
                .navigationTitle("Karte")
                .navigationBarBackButtonHidden(true)
                
                .navigationBarItems(
                    leading: NavigationLink(destination: DetailView(bathingArea: bathingArea)) {
                        Label(bathingArea.badname, systemImage: "chevron.backward")
                    },
                    trailing:
                        HStack{
                            Menu() {
                                Button(action: {
                                    includeAllMarkers.toggle()
                                    annotations.removeAll()
                                    
                                    if(includeAllMarkers) {
                                        annotations = Marker.getMarkers(bathingAreas: BathingArea.data)
                                    } else {
                                        annotations = Marker.getMarker(bathingArea: bathingArea)
                                    }
                                }) {
                                    if(includeAllMarkers) {
                                        Label("Only show Marker for '\(bathingArea.badname)'", systemImage: "eye.slash")
                                    } else {
                                        Label("Show ALL markers", systemImage: "eye")
                                    }
                                }
                            } label: {
                                Image(systemName: "ellipsis.circle")
                            }
                        }
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
    
}

