//
//  IndexingView.swift
//  Preferences
//
//  Settings > Optimizing Search and Siri
//

import SwiftUI

struct IndexingView: View {
    @Environment(\.openURL) private var openURL
    @Environment(PrimarySettingsListModel.self) private var model
    let path = "/System/Library/PreferenceBundles/SpotlightIndexingProgressSettings.bundle"
    
    var body: some View {
        CustomList(title: "Optimizing Search and Siri".localized(path: path)) {
            Section {
                HStack(alignment: .top) {
                    if let graphicIcon = UIImage.icon(forUTI: "com.apple.graphic-icon.indexing-progress") {
                        Image(uiImage: graphicIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Optimizing Search and Siri".localized(path: path))
                            .fontWeight(.semibold)
                        Text("You can use your Device as you normally would. Indexing improves search, starting with your most recent data, and can take a while. Longer charging sessions help indexing go faster.".localized(path: path))
                    }
                }
                
                Button("Learn More".localized(path: path)) {
                    openURL(URL(string: "https://support.apple.com/102321")!)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        IndexingView()
            .environment(PrimarySettingsListModel())
    }
}
