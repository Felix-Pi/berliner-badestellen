//
//  BathingArea.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 16.06.21.
//

import Foundation
import SwiftUI

let base_url = "https://www.berlin.de"

func parse_quality(farbe : String) -> WaterQuality {
    var col : String = farbe
    
    col = (col.contains(".jpg") ? col.replacingOccurrences(of: ".jpg", with: ""): col)
    col = (col.contains("_prog") ? col.replacingOccurrences(of: "_prog", with: ""): col)
    col = (col.contains("_a") ? col.replacingOccurrences(of: "_a", with: ""): col)
    
    switch col {
    case "gruen":
        return WaterQuality.green
    case "gelb":
        return WaterQuality.orange
    case "orange":
        return WaterQuality.orange
    case "rot":
        return WaterQuality.red
    default:
        return WaterQuality.gray
    }
}


func parse_additional_info(color : String) -> AdditionalInfo {    
    if(color.contains("_prog")) {return AdditionalInfo.prog}
    if(color.contains("_a")) {return AdditionalInfo.A}
    
    return AdditionalInfo.none
}

func parse_link(link: String) -> String {
    return (link.contains("\":") ? link.components(separatedBy: "\":")[1] : "")
}

struct BathingArea {
    internal init(properties: PropertiesData, coords: Coords) {
        let data : BathingAreaData = properties.data;
        
        self.id = data.id
        
        self.badname = data.badname
        self.bezirk = data.bezirk
        
        self.quality = parse_quality(farbe : data.farbe)
        
        //parse date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.YYYY"
        
        if let date = dateFormatter.date(from: data.dat) {
            self.dat = dateFormatterPrint.string(from: date)
        } else {
            self.dat = data.dat
        }
        
        self.eco = data.eco
        self.ente = data.ente
        self.sicht = data.sicht
        
        //parse & format temperature
        var temp = data.temp as NSString
        if(temp.contains(",")) {
            temp = temp.replacingOccurrences(of: ",", with: ".") as NSString
        }
        
        self.temp = String(format: "%.2f", temp.floatValue)
        
        self.prognoselink = data.prognoselink
        self.profillink = data.profillink
        self.badestellelink = data.badestellelink
        self.pdflink = data.pdflink
        
        self.prognoselinkFmt = base_url + parse_link(link: data.prognoselink)
        self.profillinkFmt = base_url + parse_link(link: data.profillink)
        self.badestellelinkFmt = base_url + parse_link(link: data.badestellelink)
        self.pdflinkFmt = parse_link(link: data.pdflink)
        
        self.latitude = coords.coordinates[0]
        self.longitude = coords.coordinates[1]
        
        self.additionalInfo = parse_additional_info(color: data.farbe)
        

        self.image = extract_image_url(url: self.badestellelinkFmt)
        self.imageUI = RemoteImage(url: self.image)
    }
    
    var id : String
    
    var badname : String
    var bezirk : String
    
    var image : String
    var imageUI : RemoteImage
    
    var quality : WaterQuality
    
    var dat : String
    var eco : String
    var ente : String
    var sicht : String
    var temp : String
    
    var prognoselink : String
    var badestellelink : String
    var profillink : String
    
    var prognoselinkFmt : String
    var badestellelinkFmt : String
    var profillinkFmt : String
    var pdflinkFmt : String
    
    var pdflink :  String
    
    var latitude : Double
    var longitude : Double
    
    var additionalInfo : AdditionalInfo
    
}

extension BathingArea {
    static var empty : BathingArea {
       
        return BathingArea(properties: PropertiesData.empty, coords: Coords.empty)
    }
    
    static var data : [BathingArea] {
        return BathingAreaJson.data
    }
}

//source: https://www.berlin.de/lageso/gesundheit/gesundheitsschutz/badegewaesser/badegewaesserueberwachung/

enum WaterQuality : Int {
    case gray = 0
    case green = 1
    case orange = 2
    case red = 3
    
    var color: Color {
        switch self {
        case .green:
            return Color.green
        case .orange:
            return Color.orange
        case .red:
            return Color.red
        default:
            return Color.gray
        }
    }
    
    var short_description: String {
        switch self {
        case .green:
            return "Zum Baden geeignet"
        case .orange:
            return "Vom Baden wird abgeraten"
        case .red:
            return "Badeverbot"
        default:
            return "-"
        }
    }
    
    
    var detailed_description: String {
        switch self {
        case .green:
            return """
- Kein Hinweis einer fäkalen Belastung unter Berücksichtigung der Angaben im Badegewässerprofil
- Keine mikrobiologischen Belastungen liegen vor bei einer Anzahl von nachfolgenden Indikatorbakterien [Koloniebildene Einheiten]/ 100 ml:
    < 1800 KBE/ 100 ml für Escherischia coli (E.coli) und
    < 700 KBE/ 100 ml für Intestinale Enterokokken (I.E.)
    < 10000 KBE/ 100 ml für Coliforme Bakterien
    < 30 µg/l Blaualgentoxine
- Das Vorhersagemodel sagt keine mikrobiologischen Belastungen voraus.
"""
        case .orange:
            return """
- Ereignisbezogene fäkale Belastung unter Berücksichtigung der Angaben im Badegewässerprofil (zum Beispiel Notauslässe)
- Es liegen mikrobiologische Belastungen vor bei einer Anzahl von nachfolgenden Indikatorbakterien [Koloniebildene Einheiten]/ 100 ml:
    > = 1800 KBE/ 100 ml für Escherischia coli (E.coli) und
    > = 700 KBE/ 100 ml für Intestinale Enterokokken (I.E.)
    > = 10000 KBE/ 100 ml für Coliforme Bakterien
    > = 30 µg/l Blaualgentoxine
- Das Vorhersagemodel sagt keine mikrobiologischen Belastungen voraus.
"""
        case .red:
            return """
- Fäkale Belastungen des Badegewässers, sowie aus anderen hygienischen Gründen (Gefahrenabwehr)
- Einzelwert wird überschritten
- Es wird unverzüglich eine zweite Probenahme durchgeführt
- Nachkontrolle: Wiederholte Überschreitung des Einzelwertes E.Coli >1800 KBE/ 100 ml oder I.E. >700 KBE/ 100 ml, Blaualgentoxine >100 µg/l
- Coliforme Bakterien werden gemäß EU nicht zur Beurteilung herangezogen
- Zuständige Behörde erlässt Badeverbot
"""
        default:
            return "-"
        }
    }
    
}

enum AdditionalInfo : String {
    case prog = "* Die hier angezeigte Bewertung wird unterstützt durch ein tagesaktuelles Vorhersagemodel."
    case A = "* Erhöhtes Algenauftreten"
    case none = ""
}
