//
//  Extensions+String.swift
//  MyNews
//
//  Created by Ersan Shimshek on 27.09.2023.
//

import Foundation

extension String {
    func trim() -> String {
        var newString = ""
        
        for char in self {
            if char == "T" {
                return newString
            }
            newString = newString + String(char)
        }
        return newString
    }
}
