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
//        Text("Berliner Badestellen").fontS
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
                Menu() {
                    Button("Sort by Temperature", action: {})
                    Button("Sort by WaterQuality", action: {})
                    Button("Sort Alphabetically", action: {})
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
        )
    }
    
}

struct Startview_Previews: PreviewProvider {
    static var previews: some View {
        Startview(bathingAreas: .constant(BathingArea.data))
    }
}
