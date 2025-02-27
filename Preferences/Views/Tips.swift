//
//  Tips.swift
//  Preferences
//
//  Settings
//

import SwiftUI
import TipKit

// MARK: Image Creation Tools Are Here
struct ImageCreationTip: Tip {
    var title: Text {
        Text("GM_ADM_CFU_TITLE", tableName: "CloudSubscriptionFeatures")
    }
    
    var message: Text? {
        Text("GM_ADM_CFU_DESCRIPTION", tableName: "CloudSubscriptionFeatures")
    }
    
    var image: Image? {
        Image("GM_ADM_CFU_IMAGE")
        
    }
}

struct ImageCreationTipView: View {
    var body: some View {
        TipView(ImageCreationTip())
            .padding(-15)
            .tipBackground(Color.background)
            .task {
                do {
                    try Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                catch {
                    print("Error initializing TipKit \(error.localizedDescription)")
                }
            }
        Button("GM_ADM_CFU_ACTION_TEXT".localize(table: "CloudSubscriptionFeatures")) {}
            .bold()
            .padding(.leading, 55)
    }
}

// MARK: Discover Apple Intelligence
struct AppleIntelligenceTip: Tip {
    var title: Text {
        Text("Discover Apple Intelligence")
    }
    
    var message: Text? {
        Text("Enhance your writing, express your creative side, and simplify your tasks.")
    }
    
    var image: Image? {
        Image(systemName: "apple.intelligence")
            .symbolRenderingMode(.multicolor)
            
    }
}

struct AppleIntelligenceTipView: View {
    var body: some View {
        TipView(AppleIntelligenceTip())
            .tipBackground(Color.background)
            .task {
                do {
                    try Tips.configure([
                        .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                catch {
                    print("Error initializing TipKit \(error.localizedDescription)")
                }
            }
        Button("Learn More") {}
            .bold()
            .padding(.leading, 70)
    }
}
