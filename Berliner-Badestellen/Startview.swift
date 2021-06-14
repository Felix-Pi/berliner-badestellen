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
                    VStack(alignment: .leading) {
                        Text(bathingArea.badname)
                            .font(.headline)
                        Spacer()
                        HStack {
                            Label("\(bathingArea.wasserqualitaet)", systemImage: "star")
                            Spacer()
                            Label("\(bathingArea.temp)", systemImage: "thermometer")
                                .padding(.trailing, 20)
                        }
                    }
                    .font(.caption)
                }
            }
        }
        .navigationTitle("Berliner Badestellen")
    }
    

}

struct Startview_Previews: PreviewProvider {
    static var previews: some View {
        Startview(bathingAreas: .constant(BathingArea.data))
    }
}
