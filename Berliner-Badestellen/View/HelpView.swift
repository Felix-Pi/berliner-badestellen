//
//  HelpView.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 18.06.21.
//

import SwiftUI

struct HelpView: View {
    struct HelpItems : Identifiable {
        var id : UUID = UUID()
        var title : String
        var text : String
        var icon : String = "info"
    }
    
    var body: some View {
        let items : [HelpItems] = [
            HelpItems(title: "E.coli (Escherichia coli)", text: "Dies sind Bakterien,die im Darm von allen Menschen und Säugetieren vorkommen und hier in der Regel harmlos sind. Außerhalb des menschlichen Körpers vermehren sich diese Keime kaum. Deshalb sind sie ein brauchbarer Anzeiger für fäkale Verunreinigungen. Dies bedeutet, dass ab Überschreiten des Grenzwertes für E.coli zu vermuten ist, dass auch andere Darmkeime, z.B. bestimmte Krankheitserreger, im Wasser vorhanden sind."),
            HelpItems(title: "Intestinale Enterokokken", text: "Dies sind Bakterien, die ähnlich wie E.coli im Darm von Mensch und Tier leben. Sie können in der Umwelt im Allgemeinen länger überdauern als E. coli. Sie sind deshalb ebenfalls ein brauchbarer Anzeiger für fäkale Verunreinigungen."),
            HelpItems(title: "Coliforme Bakterien", text: "Diese Bakterien, die sowohl im Darm als auch in der Natur vorkommen, können sich im Gegensatz zu den E.coli im Wasser vermehren, wenn sie genügend Nahrungsstoffe vorfinden. Sie haben deshalb nicht denselben hohen Indikatorwert wie E. coli. Ähnlich wie die E.coli sind auch die coliformen Bakterien nicht zwingend Kranheitserreger.\n\nDie Coliformen Keime werden in den Berliner Badegewässern untersucht, da sie recht gut zurückliegende Verunreinigungen durch Starkregenwasserereignisse bzw. diffuse fäkale Verunreinigungen im urbanen Raum ausweisen. In besonders stark genutzten, nährstoffreichen Badeseen lässt sich über die Coliformen Keime eine „Grundbelastung“ definieren, die rechtzeitige Maßnahmeplanungen der Behörden im Sinne des vorbeugenden Gesundheitsschutzes ermöglicht.\n\nÜber die regelmäßige mikrobiologische Überwachung der Badegewässer hinaus (E.coli und Intestinale Enterokokken) können aus gegebenem Anlass, z.B. bei einer vermuteten Abwassereinleitung weitere mikrobiologische Untersuchungen, z.B. auf Salmonellen (Durchfallerreger), sinnvoll sein."),
        ]
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Wasserqualität")
                .font(.headline)
            
            GroupBox(label:Label("\(WaterQuality.green.short_description)", systemImage: "circle.fill").foregroundColor(WaterQuality.green.color)) {}
            GroupBox(label:Label("\(WaterQuality.orange.short_description)", systemImage: "circle.fill").foregroundColor(WaterQuality.orange.color)) {}
            GroupBox(label:Label("\(WaterQuality.red.short_description)", systemImage: "circle.fill").foregroundColor(WaterQuality.red.color)) {}
            
            Spacer()
            
            Text("Bakterien")
                .font(.headline)
                .frame(alignment: .leading)
            ForEach(items) { item in
                GroupBox(label:Label(item.title, systemImage: item.icon).foregroundColor(.blue)) {
                    ScrollView(.vertical, showsIndicators: true) {
                        Text(item.text)
                            .font(.footnote)
                    }
                    .frame(height: 130)
                }
            }
            
            
        }
        .padding()
        .frame(alignment: .leading)
        
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
