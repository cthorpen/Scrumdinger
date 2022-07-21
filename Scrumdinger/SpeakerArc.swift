//
//  SpeakerArc.swift
//  Scrumdinger
//
//  Created by Cole Thorpen on 7/21/22.
//

import SwiftUI

struct SpeakerArc: Shape {
    
    let speakerIndex: Int
    let totalSpeakers: Int
    
    // You’ll base the number of arc segments on the number of total speakers.
    // The speaker index indicates which attendee is speaking and how many segments to draw
    // compute of a single arc in the circle based on how many speakers there are
    private var degreesPerSpeaker: Double {
        360.0 / Double(totalSpeakers)
    }
    
    private var startAngle: Angle {
        //When you draw a path, you’ll need an angle for the start and end of the arc.
        // The additional 1.0 degree is for visual separation between arc segments.
        Angle(degrees: degreesPerSpeaker * Double(speakerIndex) + 1.0)
    }
    
    private var endAngle: Angle {
        Angle(degrees: startAngle.degrees + degreesPerSpeaker - 1.0)
    }
    
    func path(in rect: CGRect) -> Path {
        
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
    }
    
}
