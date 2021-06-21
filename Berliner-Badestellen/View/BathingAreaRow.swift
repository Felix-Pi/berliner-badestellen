//
//  BathingAreaRow.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 18.06.21.
//

import SwiftUI

struct BathingAreaRow: View {
    let bathingArea: BathingArea
    
    var body: some View {       
        HStack {
            bathingArea.imageUI
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            
            
            VStack(alignment: .leading) {
                Text(bathingArea.badname)
                    .bold()
                Text(bathingArea.bezirk)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack() {
                Text("\(bathingArea.temp)°")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Image(systemName: "circle.fill").imageScale(.medium).foregroundColor(bathingArea.quality.color)
            }
        }
        .padding(.vertical, 4)
        
    }
}

struct BathingAreaRow_Previews: PreviewProvider {
    static var previews: some View {
        BathingAreaRow(bathingArea: BathingArea.data[0])
    }
}
