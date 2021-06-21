//
//  Utility.swift
//  Berliner-Badestellen
//
//  Created by Felix Pieschka on 21.06.21.
//

import Foundation


func extract_image_url(url : String) -> String {
    let base_url : String = "https://www.berlin.de"
    let regex_pattern : String = "(?<=<imgsrc=\")/imgscaler/(.*).jpg(?=\"alt)"
    
    if let url = URL(string: url) {
        do {
            var contents : String = try String(contentsOf: url)
            contents = contents.replacingOccurrences(of: "\n", with: "")
            contents = contents.replacingOccurrences(of: " ", with: "")
            
            if let regex = try? NSRegularExpression(pattern: regex_pattern, options: .caseInsensitive) {
                
                let string = contents as NSString
                        
                return regex.firstMatch(in: contents, options: [], range: NSRange(location: 0, length: string.length)).map {
                    String("\(base_url)\(string.substring(with: $0.range))")
                } as! String
            }
            
            return ""

        } catch {
            print("regex error")
            // contents could not be loaded
        }
    } else {
        print("get url error")
    }
    
    return ""
}
