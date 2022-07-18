//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/15/22.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    
    // method is called for each Label instance in a view heirarchy where this style is the current label style
    func makeBody(configuration: Configuration) -> some View {
        
        HStack {
            configuration.title
            configuration.icon
        }
        
    }
    
}

// extension to create static property trailingIcon
// Because you defined the label style as a static property, you can call it using leading-dot syntax, which makes your code more readable.
extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
