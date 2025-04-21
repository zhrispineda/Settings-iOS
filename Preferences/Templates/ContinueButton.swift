//
//  ContinueButton.swift
//  Preferences
//

import SwiftUI

struct ContinueButton: View {
    @Binding var username: String
    var loading = false
    
    var body: some View {
        ZStack {
            if loading {
                ProgressView()
            } else {
                Text("LOGIN_FORM_BUTTON_CONTINUE".localize(table: "AppleIDSetup"))
            }
        }
        .fontWeight(.medium)
        .font(.headline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(loading || username.count < 1 ? Color(UIColor.systemGray6) : Color.blue)
        .foregroundStyle(loading || username.count < 1 ? Color(UIColor.systemGray2) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    List {
        ContinueButton(username: .constant("j.appleseed"))
    }
}
