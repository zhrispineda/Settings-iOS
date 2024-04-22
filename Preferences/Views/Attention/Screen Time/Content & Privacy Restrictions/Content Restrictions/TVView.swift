//
//  TVView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > TV
//

import SwiftUI

struct TVView: View {
    // Variables
    @State private var selectedOption = "Allow All"
    let options = ["Don't Allow", "TV-Y", "TV-Y7", "TV-Y7-FV", "TV-G", "TV-PG", "TV-14", "TV-MA", "Allow All"]
    
    @State private var showMoviesCloudEnabled = true
    
    var body: some View {
        CustomList(title: "TV") {
            ForEach(options, id: \.self) { option in
                Button(action: { selectedOption = option }, label: {
                    HStack {
                        Text(option)
                            .foregroundStyle(Color["Label"])
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                })
            }
            
            Section {
                Toggle("Show TV Shows in the Cloud", isOn: $showMoviesCloudEnabled)
            }
        }
    }
}

#Preview {
    TVView()
}
