//
//  ActionButtonView.swift
//  Preferences
//
//  Settings > Action Button
//

import SwiftUI

struct ActionButtonView: View {
    // Variables
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Color.black
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomButon {
                dismiss()
            })
    }
}

struct CustomButon: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Settings")
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ActionButtonView()
}
