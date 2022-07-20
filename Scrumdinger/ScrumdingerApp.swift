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
    @State private var errorWrapper: ErrorWrapper?
    
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
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            // The modal sheet provides a closure to execute code when the user
            // dismisses the modal sheet, and a closure to supply a view to present modally.
            .sheet(item: $errorWrapper, onDismiss: {
                store.scrums = DailyScrum.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
