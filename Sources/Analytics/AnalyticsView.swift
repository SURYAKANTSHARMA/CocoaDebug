//
//  AnalyticsView.swift
//  CocoaDebug
//
//  Created by Surya on 01/05/24.
//

import SwiftUI

public
enum SDKName: String {
    case clevertap
    case firebase
    case appsflyer
}

// Model for Analytics Event
public
struct AnalyticsEvent {
    let name: String
    let properties: [String: Any]
    let sdkName: SDKName
    var timestamp: Date = Date()
}

// Updated AnalyticsManager
public
class CocoaAnalyticsManager {
    public
    static let shared = CocoaAnalyticsManager()
    
    var events: [AnalyticsEvent] = []

    public func logEvent(name: String, properties: [String: Any], sdkName: SDKName) {
        let event = AnalyticsEvent(name: name, properties: properties, sdkName: sdkName)
        events.append(event)
        // Log event to your analytics platform
        print("Event: \(name), Properties: \(properties), SDK: \(sdkName.rawValue)")
    }
}

struct AnalyticsView: View {
    var events: [AnalyticsEvent]
    
    var body: some View {
        NavigationView {
            List(events, id: \.name) { event in
                NavigationLink(destination: EventDetailView(event: event)) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Event Name: \(event.name)")
                            Text(event.sdkName.rawValue)
                                .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                .background(SwiftUI.Color.blue.opacity(0.4))
                                .cornerRadius(6)

                        }
                        Text("Timestamp: \(event.timestamp, formatter: dateFormatter)")
                            .font(.footnote)
                    }
                }
            }
            .navigationTitle("Analytics Events")
        }
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
}


#Preview {
    AnalyticsView(events: AnalyticsEvent.complexDummyEvents)
}

extension AnalyticsEvent {
    static var dummyEvent: AnalyticsEvent {
        return AnalyticsEvent(name: "Button Tapped",
                               properties: ["Button": "Button 1", "Time": Date()],
                               sdkName: .clevertap)
    }
    
    static var dummyEvents: [AnalyticsEvent] {
        return [
            AnalyticsEvent(name: "Button Tapped",
                           properties: ["Button": "Button 1", "Time": Date()],
                           sdkName: .clevertap),
            AnalyticsEvent(name: "Screen Viewed",
                           properties: ["Screen": "Home", "Time": Date()],
                           sdkName: .firebase),
            AnalyticsEvent(name: "Purchase Made",
                           properties: ["Product": "Shoes", "Price": 50.0, "Time": Date()],
                           sdkName: .appsflyer)
        ]
    }
}

extension AnalyticsEvent {
    static var complexDummyEvents: [AnalyticsEvent] {
        return [
            AnalyticsEvent(name: "Button Tapped",
                           properties: [
                               "Button": "Button 1",
                               "Time": Date(),
                               "Location": ["latitude": 40.7128, "longitude": -74.0060],
                               "User": [
                                   "id": "123456",
                                   "name": "John Doe",
                                   "age": 30,
                                   "gender": "Male"
                               ]
                           ],
                           sdkName: .clevertap),
            AnalyticsEvent(name: "Screen Viewed",
                           properties: [
                               "Screen": "Home",
                               "Time": Date(),
                               "Device": ["model": "iPhone 12", "os": "iOS 15.0"],
                               "Session": [
                                   "id": "abc123",
                                   "duration": 1200
                               ]
                           ],
                           sdkName: .firebase),
            AnalyticsEvent(name: "Purchase Made",
                           properties: [
                               "Product": "Shoes",
                               "Price": 50.0,
                               "Time": Date(),
                               "User": [
                                   "id": "789012",
                                   "name": "Jane Smith",
                                   "age": 25,
                                   "gender": "Female"
                               ]
                           ],
                           sdkName: .appsflyer)
        ]
    }
}
