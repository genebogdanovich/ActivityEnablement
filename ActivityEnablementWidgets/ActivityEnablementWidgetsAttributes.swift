//
//  ActivityEnablementWidgetsAttributes.swift
//  ActivityEnablement
//
//  Created by Gene Bogdanovich on 26.05.25.
//

import Foundation
import ActivityKit

struct ActivityEnablementWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
