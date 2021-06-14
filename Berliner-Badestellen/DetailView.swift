//
//  DetailView.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 14.06.21.
//

import SwiftUI

struct DetailView: View {
    let bathingArea: BathingArea
    
    var body: some View {
        List {
            Section(header: Text("Badestelle")) {
                HStack {
                    Text("Bezirk")
                    Spacer()
                    Text("\(bathingArea.bezirk)")
                }
                HStack {
                    Text("Badegewässer")
                    Spacer()
                    Text("\(bathingArea.profil)")
                }
            }
            
            
            Section(header: Text("Proben")) {
                HStack {
                    Text("Qualität:")
                    Spacer()
                    Text("\(bathingArea.farbe)")
                }
                
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
                    Text("Coliforme Bakterien pro 100ml")
                    Spacer()
                    Text("\(bathingArea.cb)")
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

            Section(header: Text("Sonstige")) {
                if(bathingArea.bsl != "") {
                    HStack {
                        Text("BSL")
                        Spacer()
                        Text("\(bathingArea.bsl)")
                    }
                }
                
                if(bathingArea.algen != "") {
                    HStack {
                        Text("Algen")
                        Spacer()
                        Text("\(bathingArea.algen)")
                    }
                }
                if(bathingArea.wasserqualitaet != "") {
                    HStack {
                        Text("Wasserqualitaet")
                        Spacer()
                        Text("\(bathingArea.wasserqualitaet)")
                    }
                }
                if(bathingArea.farb_id != "") {
                    HStack {
                        Text("farb_id")
                        Spacer()
                        Text("\(bathingArea.farb_id)")
                    }
                }
                if(bathingArea.wasserqualitaet_lageso != "") {
                    HStack {
                        Text("wasserqualitaet_lageso")
                        Spacer()
                        Text("\(bathingArea.wasserqualitaet_lageso)")
                    }
                }
                if(bathingArea.wasserqualitaet_predict != "") {
                    HStack {
                        Text("wasserqualitaet_predict")
                        Spacer()
                        Text("\(bathingArea.wasserqualitaet_predict)")
                    }
                }
                if(bathingArea.dat_predict != "") {
                    HStack {
                        Text("dat_predict")
                        Spacer()
                        Text("\(bathingArea.dat_predict)")
                    }
                }
            }
            
            Section(header: Text("Links")) {
                let base_url = "https://www.berlin.de"
    
                HStack {
                    
                    Link("Badestellenlink", destination: URL(string: "\(base_url + bathingArea.badestellelink)")!)
                }
                
                HStack {
                    Link("Badegewässerprofil", destination: URL(string: "\(base_url + bathingArea.profillink)")!)
                }
                HStack {
                    Link("Alle Probeentnahmen der Saision", destination: URL(string: "\(base_url + (bathingArea.pdflink))")!)
                }
            }
            
            
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("\(bathingArea.badname)")
        .navigationBarItems(trailing: Button(action: {}) {
            Image(systemName: "map")
        })
    }
    
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(bathingArea: BathingArea.data[0])
    }
}
