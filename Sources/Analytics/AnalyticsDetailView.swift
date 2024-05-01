//
//  AnalyticsDetailView.swift
//  CocoaDebug
//
//  Created by Surya on 01/05/24.
//  Copyright © 2024 man. All rights reserved.
//

import SwiftUI

import SwiftUI
import UIKit

struct EventDetailView: View {
    let event: AnalyticsEvent
    
    @State private var copiedText: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    let copyText = "\(event.name)\n\(formattedProperties())"
                    UIPasteboard.general.string = copyText
                    copiedText = "Copied!"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        copiedText = nil
                    }
                }) {
                    Image(systemName: "doc.on.doc")
                }
                .padding()
                .foregroundColor(.blue)
                .font(.title)
            }
            Text("Event Name: \(event.name)")
                .fontWeight(.semibold)
                .padding()
            ForEach(event.properties.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Text("\(key): \(value)")
                    .padding(.horizontal)
            }
            Spacer()
        }
        .navigationBarTitle(Text("Event Details"), displayMode: .inline)
        .overlay(
            Text(copiedText ?? "")
                .foregroundColor(.green)
                .padding()
                .opacity(copiedText == nil ? 0 : 1)
                .animation(.default)
                .transition(.opacity)
                .offset(y: -40)
        )
    }
    
    func formattedProperties() -> String {
        var formattedText = ""
        for (key, value) in event.properties.sorted(by: { $0.key < $1.key }) {
            formattedText += "\(key): \(value)\n"
        }
        return formattedText
    }
}

