//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/15/22.
//

import SwiftUI

struct ScrumsView: View {
    
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        List {
            // populate list using a ForEach view
            ForEach($scrums) { $scrum in
                // The destination presents a single view in the
                // navigation hierarchy when a user interacts with the element.
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        // for navigation heirarchy of the apps views
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData))
        }
    }
}
