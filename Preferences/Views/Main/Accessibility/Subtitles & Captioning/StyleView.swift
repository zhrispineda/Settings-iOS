//
//  StyleView.swift
//  Preferences
//
//  Settings > Accessibility > Subtitles & Captioning > Style
//

import SwiftUI

struct StyleView: View {
    // Variables
    @State private var selected = "Transparent Background"
    let options = ["Transparent Background", "Large Text", "Classic", "Outline Text"]
    
    var body: some View {
        CustomList(title: "Style") {
            ZStack {
                Image(UIDevice.iPhone ? "clouds1480x350" : "clouds11024x805")
                VStack {
                    ZStack {
                        switch selected {
                        case "Outline Text":
                            Text("Subtitles look like this.")
                                .foregroundStyle(.white)
                                .font(.caption)
                                .shadow(color: Color.black, radius: 1)
                                .shadow(color: Color.black, radius: 1)
                                .shadow(color: Color.black, radius: 1)
                        case "Classic":
                            Rectangle()
                                .foregroundStyle(Color.black)
                                .frame(width: 185, height: 15)
                            Text("Subtitles look like this.")
                                .foregroundStyle(.white)
                                .font(.caption)
                                .fontDesign(.monospaced)
                        case "Large Text":
                            Rectangle()
                                .foregroundStyle(Color.black).opacity(0.5)
                                .frame(width: 180, height: 23)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            Text("Subtitles look like this.")
                                .foregroundStyle(.white)
                        default:
                            Rectangle()
                                .foregroundStyle(Color.black).opacity(0.5)
                                .frame(width: 150, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            Text("Subtitles look like this.")
                                .foregroundStyle(.white)
                                .font(.caption)
                        }
                    }
                    .padding(.top, 165)
                }
            }
            .ignoresSafeArea(.all)
            .listRowBackground(Color.clear)
            .frame(height: 200)
            
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
                NavigationLink("Create New Style...", destination: StyleView())
            }
        }
    }
}

#Preview {
    NavigationStack {
        StyleView()
    }
}
