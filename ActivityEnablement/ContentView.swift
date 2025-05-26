//
//  ContentView.swift
//  ActivityEnablement
//
//  Created by Gene Bogdanovich on 26.05.25.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var task: Task<Void, Never>?
    @State private var currentActivity: Activity<ActivityEnablementWidgetsAttributes>?
    var body: some View {
        Button("Start") {
            
            do {
                let attributes = ActivityEnablementWidgetsAttributes(name: "Cute Emoji")
                let state = ActivityEnablementWidgetsAttributes.ContentState(emoji: "😜")
                
                let activity = try Activity.request(attributes: attributes, content: .init(state: state, staleDate: nil))
                self.currentActivity = activity
            } catch {
                print("❌\(error)")
            }
        }
        .onAppear {
            
            print("👻areActivitiesEnabled: \(ActivityAuthorizationInfo().areActivitiesEnabled)")
            
            self.task = Task {
                
                for await update in ActivityAuthorizationInfo().activityEnablementUpdates {
                    print("🥳\(update)")
                }
                
                
            }
        }
    }
}

#Preview {
    ContentView()
}
