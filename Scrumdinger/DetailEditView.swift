//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/18/22.
//

import SwiftUI

struct DetailEditView: View {
    
    // Declare @State properties as private so they can
    // be accessed only within the view in which you define them.
    @Binding var data: DailyScrum.Data
    
    //will hold the attendee name that the user enters
    @State private var newAttendeeName = ""
    
    var body: some View {
        // The Form container automatically adapts the appearance
        // of controls when it renders on different platforms.
        Form {
            Section(header: Text("Meeting Info")) {
                // TextField takes a binding to a String.
                // You can use the $ syntax to create a binding to
                // data.title.
                //The current view manages the state of the data property.
                TextField("Title", text: $data.title)
                HStack {
                    // Text view won’t appear on screen, but VoiceOver uses
                    // it to identify the purpose of the slider.
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                // to remove attendees from the scrum data
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        // Animation block that creates a new attendee and
                        // appends the new attendee to the attendees array.
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
