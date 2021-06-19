//
//  BathingArea.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 14.06.21.
//

import Foundation
import SwiftUI
import MapKit

struct BathingAreaJson : Codable {
    var features : [Feature]
}

struct Feature: Codable {
    var geometry : Coords
    var properties : PropertiesData
}

struct PropertiesData: Codable {
    var title : String
    var href : String
    var description : String
    var id : String
    var data : BathingAreaData
}

struct Coords : Codable {
    var coordinates : [Double]
}

struct BathingAreaData: Codable {
    var id : String
    var prognoselink : String
    var farbe : String
    var badestellelink : String
    var badname : String
    var bezirk : String
    var dat : String
    var eco : String
    var ente : String
    var sicht : String
    var temp : String
    var profillink : String
    var pdflink :  String
}


extension BathingAreaJson {
    static var data : [BathingArea] {
        let urlString = "https://www.berlin.de/lageso/gesundheit/gesundheitsschutz/badegewaesser/liste-der-badestellen/index.php/index/all.gjson?q="
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                
                if let result = try? decoder.decode(BathingAreaJson.self, from: data) {
                    var bathingAreas : [BathingArea] = []
                    
                    for ba in result.features {
                        bathingAreas.append(BathingArea(properties: ba.properties, coords: ba.geometry))
                    }
                    
                    return bathingAreas
                }
                //todo json error
            }
        }
        
        return [BathingArea.empty]
    }
    
}

extension BathingAreaJson {
    static var empty : BathingAreaJson {
        return BathingAreaJson(features: [Feature.empty])
    }
}

extension Coords {
    static var empty : Coords {
        return Coords(coordinates: [0, 0])
    }
}

extension Feature {
    static var empty : Feature {
        return Feature(geometry: Coords.empty, properties: PropertiesData.empty)
    }
    static var data : [Feature] {
        return [Feature.empty]
    }
}


extension PropertiesData {
    static var empty : PropertiesData {
        return PropertiesData(title: "", href: "", description: "", id: "", data: BathingAreaData.empty)
    }
}


extension BathingAreaData {
    static var empty : BathingAreaData {
        
        return BathingAreaData(id: "", prognoselink: "", farbe: "", badestellelink: "", badname: "", bezirk: "", dat: "", eco: "", ente: "", sicht: "", temp: "", profillink: "", pdflink: ""
        )
    }
}

