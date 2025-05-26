//
//  ActivityEnablementWidgetsLiveActivity.swift
//  ActivityEnablementWidgets
//
//  Created by Gene Bogdanovich on 26.05.25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ActivityEnablementWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ActivityEnablementWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ActivityEnablementWidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ActivityEnablementWidgetsAttributes {
    fileprivate static var preview: ActivityEnablementWidgetsAttributes {
        ActivityEnablementWidgetsAttributes(name: "World")
    }
}

extension ActivityEnablementWidgetsAttributes.ContentState {
    fileprivate static var smiley: ActivityEnablementWidgetsAttributes.ContentState {
        ActivityEnablementWidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ActivityEnablementWidgetsAttributes.ContentState {
         ActivityEnablementWidgetsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ActivityEnablementWidgetsAttributes.preview) {
   ActivityEnablementWidgetsLiveActivity()
} contentStates: {
    ActivityEnablementWidgetsAttributes.ContentState.smiley
    ActivityEnablementWidgetsAttributes.ContentState.starEyes
}
