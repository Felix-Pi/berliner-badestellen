//
//  BathingArea.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 16.06.21.
//

import Foundation

let base_url = "https://www.berlin.de"

func parse_color(color : String) -> Qulities {
    var col : String = color
    
    col = (col.contains(".jpg") ? col.replacingOccurrences(of: ".jpg", with: ""): col)
    col = (col.contains("_prog") ? col.replacingOccurrences(of: "_prog", with: ""): col)
    col = (col.contains("_a") ? col.replacingOccurrences(of: "_a", with: ""): col)
    
    switch col {
    case "gruen":
        return Qulities.green
    case "gelb":
        return Qulities.orange
    case "orange":
        return Qulities.orange
    case "rot":
        return Qulities.red
    default:
        return Qulities.gray
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
        
        self.farbeRaw = data.farbe
        self.farbe = parse_color(color: data.farbe)
        
        self.dat = data.dat
        self.eco = data.eco
        self.ente = data.ente
        self.sicht = data.sicht
        self.temp = data.temp
        
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
    }
    
    var id : String
    
    var badname : String
    var bezirk : String
    var farbeRaw : String
    var farbe : Qulities
    
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
enum Qulities : String {
    case green = "Zum Baden geeignet"
    case orange = "Vom Baden wird abgeraten"
    case red = "Badeverbot"
    case gray = "Unbekannt"
}


enum AdditionalInfo : String {
    case prog = "* Die hier angezeigte Bewertung wird unterstützt durch ein tagesaktuelles Vorhersagemodel."
    case A = "* Erhöhtes Algenauftreten"
    case none = ""
}
