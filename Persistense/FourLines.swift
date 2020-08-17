//
//  FourLines.swift
//  Persistense
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class FourLines: NSObject, NSSecureCoding, NSCopying {
    static var supportsSecureCoding = false
    

    private static let linesKey = "linesKey"
    var lines: [String]?
    
    override init() {
    }

    required init?(coder: NSCoder) {
        lines = coder.decodeObject(forKey: FourLines.linesKey) as? [String]
    }
    
    func encode(with coder: NSCoder) {
        if let saveLines = lines {
            coder.encode(saveLines, forKey: FourLines.linesKey)
        }
    }
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = FourLines()
        if let linesToCopy = lines {
            var newLines = Array<String>()
            for line in linesToCopy {
                newLines.append(line)
            }
            copy.lines = newLines
        }
        return copy
    }
    
}
