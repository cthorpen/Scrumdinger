//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/15/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            // for navigation heirarchy of the apps views
            NavigationView {
                ScrumsView(scrums: DailyScrum.sampleData)
            }
        }
    }
}
