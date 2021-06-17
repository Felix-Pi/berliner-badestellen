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
    @State private var isPresented = false
    
    var body: some View {
        List {
            Section(header: Text("Badestelle")) {
                HStack {
                    Text("Badestelle")
                    Spacer()
                    Text("\(bathingArea.badname)")
                }
                HStack {
                    Text("Bezirk")
                    Spacer()
                    Text("\(bathingArea.bezirk)")
                }
                
                HStack {
                    Text("Qualität")
                    Spacer()
                    Text("\(bathingArea.farbe.rawValue)")
                }
                
            }
            
            
            Section(header: Text("Proben")) {
                HStack {
                    Text("Temperatur")
                    Spacer()
                    Text("\(bathingArea.temp)°C")
                }
                
                HStack {
                    Text("Sichttiefe")
                    Spacer()
                    Text("\(bathingArea.sicht) cm")
                }
                HStack {
                    Text("E.coli pro 100ml")
                    Spacer()
                    Text("\(bathingArea.eco)")
                }
                
                HStack {
                    Text("Intestinale Enterokokken pro 100 ml")
                    Spacer()
                    Text("\(bathingArea.ente)")
                }
                
                HStack {
                    Text("Probeentnahme")
                    Spacer()
                    Text("\(bathingArea.dat)")
                }
            }
            
            Section(header: Text("Links")) {
                let base_url = "https://www.berlin.de"
                
                HStack {
                    
                    Link("Badestellenlink", destination: URL(string: "\(base_url + bathingArea.badestellelinkFmt)")!)
                }
                HStack {
                    Link("Badegewässerprofil", destination: URL(string: "\(base_url + bathingArea.profillinkFmt)")!)
                }
                
                HStack {
                    Link("Prognoselink", destination: URL(string: "\(base_url + bathingArea.profillinkFmt)")!)
                }
                
                HStack {
                    Link("Alle Probeentnahmen der Saision", destination: URL(string: "\(bathingArea.pdflinkFmt)")!)
                }
            }
            
            
        }

        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(bathingArea.badname, displayMode: .inline)
        .navigationBarItems(
            trailing: NavigationLink(destination: MapView(bathingArea: bathingArea)) {
                Image(systemName: "map")
            }
        )
       
    }
    

}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(bathingArea: BathingArea.data[0])
    }
}
