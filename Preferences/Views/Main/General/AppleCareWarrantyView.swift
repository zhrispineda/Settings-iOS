//
//  AppleCareWarrantyView.swift
//  Preferences
//
//  Settings > General > AppleCare & Warranty
//

import SwiftUI

struct AppleCareWarrantyView: View {
    let path = "/System/Library/PrivateFrameworks/NewDeviceOutreachUI.framework"
    
    var body: some View {
        ScrollView {
            ZStack {
                Spacer().containerRelativeFrame(.vertical)
                ContentUnavailableView(
                    "CC_NO_ACCOUNT_ERROR_TITLE".localized(path: path),
                    systemImage: "person.crop.circle",
                    description: Text("CC_NO_ACCOUNT_ERROR_SUBTITLE".localized(path: path))
                )
            }
        }
        .navigationTitle("COVERAGE".localize(table: "General"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AppleCareWarrantyView()
    }
}
