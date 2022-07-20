//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/20/22.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    // With the @Environment property wrapper,
    // you can read a value that the view’s environment stores
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                // Error provides a localized string description.
                // If the error’s user info dictionary doesn’t provide
                // a value for the description key, the system constructs
                // a localized string from the domain and code.
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        // dismiss is a structure.
                        // You can call a structure like a
                        // function if it includes callAsFunction().
                        dismiss()
                    }
                }
            }
        }
    }
        
}

struct ErrorView_Previews: PreviewProvider {
    
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this sample error.")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
