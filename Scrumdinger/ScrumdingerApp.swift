//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/15/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @State private var scrums = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            // for navigation heirarchy of the apps views
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
