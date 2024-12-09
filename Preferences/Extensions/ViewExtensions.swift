//
//  ViewExtensions.swift
//  Preferences
//

import SwiftUI

extension View {
    func usernameTextStyle() -> some View {
        modifier(UsernameTextStyle())
    }
}

struct UsernameTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .frame(height: 45)
            .padding(.leading, 20)
            .background(Color(UIColor.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
