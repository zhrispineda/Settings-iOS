//
//  StyleView.swift
//  Preferences
//
//  Settings > Accessibility > Subtitles & Captioning > Style
//

import SwiftUI

struct StyleView: View {
    // Variables
    @State private var selected = "MALocalize-MADefault"
    let options = ["MALocalize-MADefault", "MALocalize-MALargeText", "MALocalize-MAClassic", "MALocalize-MAOutlineText"]
    let table = "Captioning"
    let nameTable = "ProfileNames"
    
    var body: some View {
        CustomList(title: "CAPTION_THEME".localize(table: table)) {
            ZStack {
                Image(UIDevice.iPhone ? "clouds1480x350" : "clouds11024x805")
                VStack {
                    ZStack {
                        switch selected {
                        case "MALocalize-MAOutlineText":
                            Text("SAMPLE_CAPTION_TEXT", tableName: table)
                                .foregroundStyle(.white)
                                .font(.caption)
                                .shadow(color: Color.black, radius: 1)
                                .shadow(color: Color.black, radius: 1)
                                .shadow(color: Color.black, radius: 1)
                        case "MALocalize-MAClassic":
                            Rectangle()
                                .foregroundStyle(Color.black)
                                .frame(width: 190, height: 15)
                            Text("SAMPLE_CAPTION_TEXT", tableName: table)
                                .foregroundStyle(.white)
                                .font(.caption)
                                .fontDesign(.monospaced)
                        case "MALocalize-MALargeText":
                            Rectangle()
                                .foregroundStyle(Color.black).opacity(0.5)
                                .frame(width: 190, height: 23)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            Text("SAMPLE_CAPTION_TEXT", tableName: table)
                                .foregroundStyle(.white)
                        default:
                            Rectangle()
                                .foregroundStyle(Color.black).opacity(0.5)
                                .frame(width: 150, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            Text("SAMPLE_CAPTION_TEXT", tableName: table)
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
                Picker("CAPTION_THEME".localize(table: table), selection: $selected) {
                    ForEach(options, id: \.self) { option in
                        Text(option.localize(table: nameTable))
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
                NavigationLink("create.new.theme".localize(table: table), destination: StyleView())
            }
        }
    }
}

#Preview {
    NavigationStack {
        StyleView()
    }
}
