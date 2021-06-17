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
        List {
            ForEach(bathingAreas, id: \.id) { bathingArea in
                NavigationLink(destination: DetailView(bathingArea: bathingArea)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(bathingArea.badname)
                                .font(.headline)
                            
                            Text(bathingArea.bezirk)
                                .font(.footnote)
                                .foregroundColor(Color.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            
                            Text("\(bathingArea.temp)°C")
                                .foregroundColor(Color.secondary)
                                .padding(.trailing)
                            
                            switch bathingArea.farbe {
                            case Qulities.green:
                                Label("", systemImage: "circle.fill").foregroundColor(Color.green)
                            case Qulities.orange:
                                Label("", systemImage: "circle.fill").foregroundColor(Color.orange)
                            case Qulities.red:
                                Label("", systemImage: "circle.fill").foregroundColor(Color.red)
                            default:
                                Label("", systemImage: "circle.fill").foregroundColor(Color.gray)
                            }
                            
                        }
                    }
                    .font(.caption)
                }
                .navigationBarTitle("Badestellen", displayMode: .inline)
            }
            
        }
        
        .navigationBarItems(
            trailing:
                HStack{
                    Menu() {
                        Text("Bedestellen Sortieren nach")
                        
                        Button(action: { bathingAreas.sort { $0.temp > $1.temp } }) {
                            Label("Temperatur", systemImage: "arrow.down")
                        }
                        Button(action: { bathingAreas.sort { $0.farbe.rawValue > $1.farbe.rawValue } }) {
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
