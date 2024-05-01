//
//  AnalyticsDetailView.swift
//  CocoaDebug
//
//  Created by Surya on 01/05/24.
//  Copyright © 2024 man. All rights reserved.
//

import SwiftUI

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
                            propertyView(key: nestedKey, value: nestedValue)
                                .padding(.horizontal)
                        }
                    }
                } else {
                    // If the value is not a dictionary, display it directly
                    propertyView(key: key, value: value)
                        .padding(.horizontal)
                }
            }
            Spacer()
        }
        .navigationBarTitle(Text("Event Details"), displayMode: .inline)
    }
    
    @ViewBuilder
    func propertyView(key: String, value: Any) -> some View {
        HStack {
            Text(key)
                .font(.subheadline)
            Spacer()
            if let typeTag = valueTypeTag(value) {
                Text("\(value)")
                    .foregroundColor(.primary)
                Text("(\(typeTag))")
                    .font(.subheadline)
                    .padding(.horizontal, 5)
                    .background(SwiftUI.Color.blue.opacity(0.2))
                    .cornerRadius(5)
            } else {
                Text("\(value)")
                    .font(.subheadline)
            }
        }
    }
    
    func valueTypeTag(_ value: Any) -> String? {
        switch value {
        case is String: return "String"
        case is Int: return "Int"
        case is Double: return "Double"
        case is Float: return "Float"
        case is Bool: return "Bool"
        case is Date: return "Date"
        default: return nil
        }
    }
}
