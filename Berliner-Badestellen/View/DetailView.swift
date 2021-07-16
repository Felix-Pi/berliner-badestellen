//
//  DetailView.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 14.06.21.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let bathingArea: BathingArea
    @State var bathingAreas: [BathingArea]
    
    @State private var showHelpSheetView = false
    
    
    var body: some View {
        VStack {
            List {
                Section {
                    bathingArea.imageUI
                        .cornerRadius(15)
                        .frame(height: 300)
                }.listRowInsets(EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0))
                
                
                Section(header: Text("Badestelle")) {
                    HStack {
                        Text("Bezirk")
                        Spacer()
                        Text("\(bathingArea.bezirk)").foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Qualität")
                        Spacer()
                        Text("\(bathingArea.quality.short_description)")
                            .bold()
                            .foregroundColor(bathingArea.quality.color)
                    }
                    
                }
                
                Section(
                    header:
                        HStack {
                            Text("Proben")
                            Spacer()
                            Button(action: { showHelpSheetView = true }) {
                                Text("Was bedeuten diese Werte?")
                            }
                        }, footer: Text(bathingArea.additionalInfo.rawValue)) {
                    HStack {
                        Text("Temperatur")
                        Spacer()
                        Text("\(bathingArea.temp)°C").foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Sichttiefe")
                        Spacer()
                        Text("\(bathingArea.sicht) cm").foregroundColor(.secondary)
                    }
                    HStack {
                        Text("E.coli pro 100ml")
                        Spacer()
                        Text("\(bathingArea.eco)").foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Intestinale Enterokokken pro 100 ml")
                        Spacer()
                        Text("\(bathingArea.ente)").foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Probeentnahme")
                        Spacer()
                        Text("\(bathingArea.dat)").foregroundColor(.secondary)
                    }
                }
                
                
                Section(header: Text("Links")) {
                    HStack {
                        
                        Link("Badestellenlink", destination: URL(string: "\(bathingArea.badestellelinkFmt)")!)
                    }
                    HStack {
                        Link("Badegewässerprofil", destination: URL(string: "\(bathingArea.profillinkFmt)")!)
                    }
                    
                    HStack {
                        Link("Prognoselink", destination: URL(string: "\(bathingArea.profillinkFmt)")!)
                    }
                    
                    HStack {
                        Link("Alle Probeentnahmen der Saision", destination: URL(string: "\(bathingArea.pdflinkFmt)")!)
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle(bathingArea.badname, displayMode: .inline)
        .navigationBarItems(
            trailing:
                HStack {
                    NavigationLink(destination: MapView.view(bathingArea: bathingArea,bathingAreas: bathingAreas, annotations: Marker.getMarker(bathingArea: bathingArea), zoom: MapView.zomm_one_marker)) {
                        Image(systemName: "map")
                    }
                }
        )
        
        .sheet(isPresented: $showHelpSheetView) {
            VStack() {
                HStack {
                    Text("Erklärungen").font(.headline)
                    Spacer()
                    Button(action: { showHelpSheetView = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    
                }
                .padding()
                
                ScrollView {
                    HelpView()
                }
                .padding()
            }
        }
        
        
        
    }
    
    
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(bathingArea: BathingArea.empty, bathingAreas: [BathingArea.empty])
    }
}
