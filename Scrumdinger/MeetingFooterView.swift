//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/19/22.
//

import SwiftUI

struct MeetingFooterView: View {
    
    let speakers: [ScrumTimer.Speaker]
    // closure property
    var skipAction: () -> Void
    
    // determines speaker number
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: {!$0.isCompleted}) else {return nil}
        return index + 1
    }
    
    // checks whether the active speaker is the last speaker
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy({$0.isCompleted})
    }
    
    // return info about the active speaker and pass it to the text view
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else {return "No More Speakers"}
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        // stack including number of speakers and forward button
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName:"forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
