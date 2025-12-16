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
            .frame(height: 50)
            .padding(.leading, 15)
            .background(.fill)
            .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
