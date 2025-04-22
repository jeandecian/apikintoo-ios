//
//  JSONView.swift
//  APIkintoo
//
//  Created by Jean Decian on 2025-04-21.
//

import SwiftUI

struct JSONView: View {
    let data: Any
    
    var body: some View {
        if let dict = data as? [String: Any] {
            List(dict.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                NavigationLink(destination: JSONView(data: value)) {
                    HStack {
                        Text(key)
                        Spacer()
                        Text(summary(value))
                            .foregroundStyle(.gray)
                    }
                }
            }
        } else if let array = data as? [Any] {
            List(array.indices, id: \.self) { index in
                NavigationLink(destination: JSONView(data: array[index])) {
                    Text("[\(index)] \(summary(array[index]))")
                }
            }
        } else {
            Text(String(describing: data))
                .padding()
        }
    }
    
    func summary(_ value: Any) -> String {
        if value is [String: Any] {
            return "{...}"
        } else if value is [Any] {
            return "[...]"
        } else {
            return String(describing: value)
        }
    }
}
