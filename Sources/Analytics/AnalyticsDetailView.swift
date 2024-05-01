//
//  AnalyticsDetailView.swift
//  CocoaDebug
//
//  Created by Surya on 01/05/24.
//  Copyright © 2024 man. All rights reserved.
//

import SwiftUI

// EventDetailView SwiftUI View
struct EventDetailView: View {
    let event: AnalyticsEvent

    var body: some View {
        VStack(alignment: .leading) {
            Text("Event Name: \(event.name)")
                .padding()

            // Display properties
            ForEach(event.properties.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                if let nestedDict = value as? [String: Any] {
                    // If the value is a dictionary, display its keys and values recursively
                    VStack(alignment: .leading) {
                        Text(key)
                            .font(.headline)
                        ForEach(nestedDict.sorted(by: { $0.key < $1.key }), id: \.key) { nestedKey, nestedValue in
                            Text("- \(nestedKey): \(nestedValue)")
                                .padding(.horizontal)
                        }
                    }
                } else {
                    // If the value is not a dictionary, display it directly
                    Text("\(key): \(value)")
                        .padding(.horizontal)
                }
            }
            Spacer()
        }
        .navigationBarTitle(Text("Event Details"), displayMode: .inline)
    }
}
