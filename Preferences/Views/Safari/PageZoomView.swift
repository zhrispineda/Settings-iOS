//
//  PageZoomView.swift
//  Preferences
//
//  Settings > Safari > Page Zoom
//

import SwiftUI

struct PageZoomView: View {
    // Variables
    @State private var selectedOption = "100%"
    let options = ["50%", "75%", "100%", "115%", "125%", "150%", "175%", "200%", "250%", "300%"]
    
    var body: some View {
        CustomList(title: "Page Zoom") {
            Section {
                ForEach(options, id: \.self) { option in
                    Button { selectedOption = option } label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } header: {
                Text("\n\nPage Zoom On All Websites")
            }
        }
        .toolbar {
            EditButton()
                .disabled(true)
        }
    }
}

#Preview {
    NavigationStack {
        PageZoomView()
    }
}
