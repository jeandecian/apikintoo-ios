//
//  ContentView.swift
//  APIkintoo
//
//  Created by Jean Decian on 2025-04-21.
//

import SwiftUI

struct ContentView: View {
    @State private var apiURL = ""
    @State private var jsonData: Any?

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter API URL", text: $apiURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Fetch JSON") {
                    fetchData(from: apiURL)
                }
                .padding()

                if let json = jsonData {
                    JSONView(data: json)
                        .padding()
                } else {
                    Spacer()
                }
            }
            .navigationTitle("APIkintoo")
        }
    }

    func fetchData(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data)
                DispatchQueue.main.async {
                    self.jsonData = json
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
