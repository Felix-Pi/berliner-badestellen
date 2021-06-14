//
//  BathingArea.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 14.06.21.
//

import Foundation
import SwiftUI


//{
//  messages: {
//    messages: [], /* Array mit Meldungen, i.d.R. leer */
//    success: NULL /* Bool mit Status der Ausführung, bei FALSE ist ein Fehler aufgetreten *(
//  },
//  results: {
//    count: 113, /* Anzahl der Gesamtergebnisse */
//    items_per_page: null /* Anzahl der Einträge pro Seite */
//  },
//  index: [
//    {/* Einzelne Ergebniszeile */},
//    {/* Einzelne Ergebniszeile */},
//    {/* Einzelne Ergebniszeile */},
//    {/* Einzelne Ergebniszeile */}
//  ]
//  item: {} /* Wird nur für Detaildatensätze verwendet */
//}


struct DataWrapper: Codable {
    var index: [BathingArea]
}


struct BathingArea: Codable {   
    var id : String
    var prognoselink : String
    var farbe : String //
    var badestellelink : String //
    var badname : String //
    var bezirk : String //
    var dat : String
    var cb : String //
    var eco :String //
    var ente :String //
    var sicht : String //
    var temp : String //
    var profil : String //
    var profillink : String //
    var pdflink :  String //
    var rss_name :  String
    var bsl : String
    var algen : String
    var wasserqualitaet : String
    var farb_id : String
    var wasserqualitaet_lageso : String
    var wasserqualitaet_predict : String
    var dat_predict : String
}



extension BathingArea {
    static var data : [BathingArea] {
        var bathingAreas = [BathingArea]()
        
        let urlString = "https://www.berlin.de/lageso/gesundheit/gesundheitsschutz/badegewaesser/liste-der-badestellen/index.php/index/all.json?q="

         if let url = URL(string: urlString) {
             if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()

                 if let jsonPetitions = try? decoder.decode(DataWrapper.self, from: data) {
                     bathingAreas = jsonPetitions.index
                    
                    print(bathingAreas)
                    
                    for (index, ba) in bathingAreas.enumerated() {
                        bathingAreas[index].badestellelink = bathingAreas[index].badestellelink.components(separatedBy: ":")[1]
                        bathingAreas[index].profillink = bathingAreas[index].profillink.components(separatedBy: ":")[1]
                        bathingAreas[index].pdflink = bathingAreas[index].pdflink.components(separatedBy: ":")[1]
                    }
                    
    
                    
                    return bathingAreas
                 }
             }
         }
        
                    return [BathingArea(id: "none", prognoselink: "none", farbe: "none", badestellelink: "none", badname: "none", bezirk: "none", dat: "none", cb: "none", eco: "none", ente: "none", sicht: "none", temp: "none", profil: "none", profillink: "none", pdflink: "none", rss_name: "none", bsl: "none", algen: "none", wasserqualitaet: "none", farb_id: "none", wasserqualitaet_lageso: "none", wasserqualitaet_predict: "none", dat_predict: "none")]
    }

}

