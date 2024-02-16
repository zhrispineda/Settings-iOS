//
//  AppsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Content Restrictions > Apps
//

import SwiftUI

struct AppsView: View {
    // Variables
    @State private var selectedOption = "17+"
    let options = ["Don't Allow", "4+", "9+", "12+", "17+"]
    
    var body: some View {
        CustomList(title: "Apps") {
            ForEach(options, id: \.self) { option in
                Button(action: { selectedOption = option }, label: {
                    HStack {
                        Text(option)
                            .foregroundStyle(Color(UIColor.label))
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                })
            }
        }
    }
}

#Preview {
    AppsView()
}
