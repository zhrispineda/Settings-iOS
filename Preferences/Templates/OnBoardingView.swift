/*
 Abstract:
 Based off of OnBoardingKit, relies on CFBundleURLTypes to fire onOpenURL.
 URLs do not open in Preview; use Simulator, a physical device, or
 manually set the variable for displaying the sheet to true to view.
 */

import SwiftUI

/// A `ScrollView` container for displaying OnBoardingKit-like views for providing system information.
///
/// ```swift
/// var body: some View {
///     OnBoardingView(table: "BatteryUI")
/// }
/// ```
///
/// - Parameter title: The text to use as the title.
/// - Parameter summary: The text to use as the summary.
/// - Parameter footer: The text to use as the footer.
/// - Parameter secondFooter: The text to use as a second footer.
struct OnBoardingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var textHeight = 0.0
    @State private var viewHeight = 0.0
    var title: String
    var summary: String
    var footer: String
    var secondFooter = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer(minLength: 40)
                Group {
                    // Splash title
                    Text(.init(title))
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                    
                    // Summary text
                    Text(.init(summary))
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 10)
                    
                    // Footer text
                    Text(.init(footer))
                        .font(.caption)
                    
                    if !secondFooter.isEmpty {
                        Text(.init(secondFooter))
                            .font(.caption)
                            .padding(.top, 10)
                    }
                }
                .padding(.horizontal, 45)
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            textHeight = geo.size.height
                        }
                    }
                }
            }
            .scrollDisabled(textHeight < viewHeight && UIDevice.iPhone)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
        .overlay {
            GeometryReader { geo in
                Color.clear.onAppear {
                    viewHeight = geo.size.height
                    
                }
            }
        }
    }
}

#Preview {
    OnBoardingView(title: "Title", summary: "Summary", footer: "Footer")
}
