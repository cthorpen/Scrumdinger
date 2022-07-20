//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/15/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    // The @StateObject property wrapper creates a single instance of
    // an observable object for each instance of the structure that declares it.
   @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            // for navigation heirarchy of the apps views
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    // Task creates a new asynchronous context
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            fatalError("Error saving scrums.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    fatalError("Error loading scrums.")
                }
            }
        }
    }
}
