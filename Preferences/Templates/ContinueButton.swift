//
//  ContinueButton.swift
//  Preferences
//

import SwiftUI

/// Button labeled `Continue` that is used for logins. Replaces text with a ProgressView when loading is set to true.
struct ContinueButton: View {
    @Binding var username: String
    var text: LocalizedStringKey = "LOGIN_FORM_BUTTON_CONTINUE"
    var table = "AppleIDSetup"
    var loading = false
    
    var body: some View {
        ZStack {
            if loading {
                ProgressView()
            } else {
                Text(text, tableName: table)
            }
        }
        .fontWeight(.semibold)
        .font(.headline)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(loading || username.count < 1 ? Color(UIColor.systemGray6) : Color.blue)
        .foregroundStyle(loading || username.count < 1 ? Color(UIColor.systemGray2) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .glassEffect()
    }
}

#Preview {
    List {
        ContinueButton(username: .constant("j.appleseed"))
    }
}
