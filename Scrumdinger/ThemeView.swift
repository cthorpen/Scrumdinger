//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/18/22.
//

import SwiftUI

struct ThemeView: View {
    
    let theme: Theme
    
    var body: some View {
        // Because a ZStack overlays views back to front,
        // the RoundedRectangle acts as a background and
        // appears behind the views listed below it.
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label(theme.name, systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .buttercup)
    }
}
