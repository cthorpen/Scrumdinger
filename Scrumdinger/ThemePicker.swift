//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/18/22.
//

import SwiftUI

struct ThemePicker: View {
    
    // Try to maintain a single source of truth for every piece of data in your app.
    // Instead of creating a new source of truth for the theme picker,
    // you’ll use a binding that references a theme structure defined
    // in the parent view.
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                // You can tag subviews when you need to differentiate
                // among them in controls like pickers and lists.
                // Tag values can be any hashable type like in an enumeration
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
