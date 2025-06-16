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
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        content
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .frame(height: 45)
            .padding(.leading, 20)
            .background(Color(colorScheme == .dark ? UIColor.systemGray5 : UIColor.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}
