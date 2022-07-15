//
//  Theme.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/15/22.
//

import SwiftUI

//theme enumeration for meetings
enum Theme: String {
    //cases for each color listed in the Themes folder in the assets catalog
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    // accentColor property that returns .black or .white based on the value of self
    var accentColor: Color {
            switch self {
            case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
            case .indigo, .magenta, .navy, .oxblood, .purple: return .white
            }
        }
    
    // mainColor property creates a color using the enum's rawValue. initializes a color from the asset catalog
    var mainColor: Color {
        Color(rawValue)
    }
    
}
