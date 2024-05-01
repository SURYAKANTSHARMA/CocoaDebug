//
//  AnalyticsView.swift
//  CocoaDebug
//
//  Created by Surya on 01/05/24.
//

import SwiftUI
enum SDKName: String {
    case clevertap
    case firebase
    case appsflyer
}

// Model for Analytics Event
struct AnalyticsEvent {
    let name: String
    let properties: [String: Any]
    let sdkName: SDKName
}

// Updated AnalyticsManager
class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    var events: [AnalyticsEvent] = []

    func logEvent(name: String, properties: [String: Any], sdkName: SDKName) {
        let event = AnalyticsEvent(name: name, properties: properties, sdkName: sdkName)
        events.append(event)
        // Log event to your analytics platform
        print("Event: \(name), Properties: \(properties), SDK: \(sdkName.rawValue)")
    }
}

// Updated AnalyticsView
struct AnalyticsView: View {
    var body: some View {
        NavigationView {
            List(AnalyticsManager.shared.events, id: \.name) { event in
                NavigationLink(destination: EventDetailView(event: event)) {
                    VStack(alignment: .leading) {
                        Text("Event Name: \(event.name)")
                        Text("SDK: \(event.sdkName.rawValue)")
                    }
                }
            }
            .navigationTitle("Analytics Events")
        }
    }
}

// EventDetailView remains the same

struct AnalyticsView: View {
    var body: some View {
        NavigationView {
            List(AnalyticsManager.shared.events, id: \.name) { event in
                NavigationLink(destination: EventDetailView(event: event)) {
                    VStack(alignment: .leading) {
                        Text("Event Name: \(event.name)")
                        Text("SDK: \(event.sdkName.rawValue)")
                    }
                }
            }
            .navigationTitle("Analytics Events")
        }
    }
}


#Preview {
    AnalyticsView()
}
