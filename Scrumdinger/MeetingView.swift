//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/15/22.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            // progress bar
            ProgressView(value: 5, total: 15)
            // horizontal stack including seconds elapsed and remaining
            HStack {
                // seconds elapsed label
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                // seconds remaining label
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            }
            // accessibility features of above stacks 
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time Remaining")
            .accessibilityValue("10 minutes")
            //progress circle with circle's attributes
            Circle()
                .strokeBorder(lineWidth: 24)
            // stack including number of speakers and forward button
            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next speaker")
            }
        }
        //padding of whole VStack
        .padding()
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }
}
