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
                    // passing a saveAction closure to the list view
                    ScrumStore.save(scrums: store.scrums) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                ScrumStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let scrums):
                        store.scrums = scrums
                    }
                }
            }
        }
    }
}
