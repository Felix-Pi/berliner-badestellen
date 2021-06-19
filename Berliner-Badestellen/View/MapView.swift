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

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        parent.isMarkerSelected = true
        let selected : String = (view.annotation?.title ?? "")!
        parent.selectedMarker = BathingArea.data.filter { $0.badname.contains(selected) }.first ?? BathingArea.empty
    }
        
    
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView){
        parent.isMarkerSelected = false
        parent.selectedMarker = BathingArea.empty
    }
    
    
}

struct MapView: UIViewRepresentable {
    let bathingArea: BathingArea
    @Binding var annotations : [Marker]
    var zoom : Double = 0.05
    
    let mulm : Int = 0
    static let zomm_one_marker : Double = 0.05
    static let zomm_all_markers : Double = 0.6
    static let berlin_coords : [Double] = [13.400,52.5067614]
    
    typealias Context = UIViewRepresentableContext<Self>
    
    @Binding var isMarkerSelected : Bool
    @Binding var selectedMarker : BathingArea
    
    var locationManager = CLLocationManager()
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        //location request
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: bathingArea.longitude, longitude: bathingArea.latitude), span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)), animated: true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if(annotations.count + 1 != uiView.annotations.count) { //+1 because of user location
            uiView.removeAnnotations(uiView.annotations)
        }
        
        uiView.addAnnotations(annotations)
        
        //animate region
        var region : MKCoordinateRegion = uiView.region
        region.span = MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom)
        uiView.setRegion(region, animated: true)
    }
    
    
    
    
    struct view_small: View {
        @State var bathingArea: BathingArea
        @State var annotations : [Marker]
        @State var zoom : Double = MapView.zomm_one_marker
        
        @State private var includeAllMarkers = false
        
        @State private var isMarkerSelected = false
        @State private var selectedMarker = BathingArea.empty
        
        var body: some View {
            MapView(bathingArea: bathingArea, annotations: $annotations, zoom: zoom, isMarkerSelected: $isMarkerSelected, selectedMarker: $selectedMarker)
                .navigationTitle("Karte")
                .navigationBarBackButtonHidden(true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
    
    
    struct view: View {
        @State var bathingArea: BathingArea
        @State var annotations : [Marker]
        @State var zoom : Double = MapView.zomm_one_marker
        
        @State private var includeAllMarkers = false
        
        @State var isMarkerSelected = false
        @State private var selectedMarker = BathingArea.empty
        
        var body: some View {
            MapView(bathingArea: bathingArea, annotations: $annotations, zoom: zoom, isMarkerSelected: $isMarkerSelected, selectedMarker: $selectedMarker)
                .navigationTitle("Karte")
                .navigationBarBackButtonHidden(true)
                
                .navigationBarItems(
                    leading: NavigationLink(destination: DetailView(bathingArea: bathingArea)) {
                        Label(bathingArea.badname, systemImage: "chevron.backward")
                    },
                    trailing:
                        HStack{
                            if(isMarkerSelected && includeAllMarkers) {
                                NavigationLink(destination: DetailView(bathingArea: selectedMarker)) {
                                    Text("Öffnen")
                                }
                                
                            }
                            Menu() {
                                Button(action: {
                                    includeAllMarkers.toggle()
                                    annotations.removeAll()
                                    
                                    if(includeAllMarkers) {
                                        annotations = Marker.getMarkers(bathingAreas: BathingArea.data)
                                        zoom = MapView.zomm_all_markers
                                    } else {
                                        annotations = Marker.getMarker(bathingArea: bathingArea)
                                        zoom = MapView.zomm_one_marker
                                    }
                                }) {
                                    if(includeAllMarkers) {
                                        Label("Nur '\(bathingArea.badname)' anzeigen", systemImage: "eye.slash")
                                    } else {
                                        Label("Alle Badestellen anzeigen", systemImage: "eye")
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



