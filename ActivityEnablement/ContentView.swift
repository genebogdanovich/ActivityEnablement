//
//  ContentView.swift
//  ActivityEnablement
//
//  Created by Gene Bogdanovich on 26.05.25.
//

import SwiftUI
import ActivityKit
import CoreLocation

struct TrackPoint: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
    init(location: CLLocation) {
        self.coordinate = location.coordinate
    }
}

struct ContentView: View {
    @State private var permissionTrackingTask: Task<Void, Never>?
    @State private var currentActivity: Activity<ActivityEnablementWidgetsAttributes>?
    
    @State private var locationTask: Task<Void, Error>?
    
    @State private var trackPoints: [TrackPoint] = []
    
    
    private let activityAuthorizationInfo = ActivityAuthorizationInfo()
    
    var body: some View {
        List {
            Button("Start Location Tracking & Live Activity") {
                
                Task {
                    do {
                        let attributes = ActivityEnablementWidgetsAttributes(name: "Cute Emoji")
                        let state = ActivityEnablementWidgetsAttributes.ContentState(emoji: "😜")
                        
                        let activity = try Activity.request(attributes: attributes, content: .init(state: state, staleDate: nil))
                        self.currentActivity = activity
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    } catch {
                        print("❌\(error)")
                    }
                    
                    
                    self.locationTask = Task {
                        for try await update in CLLocationUpdate.liveUpdates() {
                            if let location = update.location {
                                trackPoints.append(TrackPoint(location: location))
                                print("📍 Added location.")
                            }
                        }
                    }
                }
            }
            
            Text("Count: \(trackPoints.count)")
            
            ForEach(trackPoints) { point in
                Text("\(point.coordinate)")
                
            }
        }
        .onAppear {
            
            print("👻areActivitiesEnabled: \(activityAuthorizationInfo.areActivitiesEnabled)")
            
            self.permissionTrackingTask = Task {
                
                
                
                
                
                
                for await update in activityAuthorizationInfo.activityEnablementUpdates {
                    print("🥳\(update)")
                }
                
                
            }
        }
    }
}

#Preview {
    ContentView()
}
