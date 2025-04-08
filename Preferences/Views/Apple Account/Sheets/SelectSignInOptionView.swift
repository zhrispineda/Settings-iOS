//
//  SelectSignInOptionView.swift
//  Preferences
//
//  Settings > Apple Account
//

import SwiftUI

struct SelectSignInOptionView: View {
    // Variables
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    let table = "AppleIDSetup"
    
    var body: some View {
        List {
            // Animated Apple logo, title, and description
            VStack(spacing: 10) {
                animatedHeader()
                    .frame(height: 100)
                Text("LOGIN_FORM_TITLE", tableName: table)
                    .font(.largeTitle)
                    .bold()
                Text("SIGN_IN_OPTIONS_DESCRIPTION", tableName: table)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 0)
            
            // Use Another Apple Device Button
            Section {
                Button {
                    dismiss()
                } label: {
                    SignInMethodButton(image: "ProximitySymbol-iPhone-iPad", title: "SIGN_IN_OPTION_ANOTHER_DEVICE_TITLE", subtitle: "SIGN_IN_OPTION_ANOTHER_DEVICE_SUBTITLE", table: table)
                }
                .foregroundStyle(.primary)
                .listRowBackground(Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.secondarySystemGroupedBackground))
            }
            
            // Sign in Manually button
            Section {
                NavigationLink {
                    AppleAccountLoginView()
                } label: {
                    SignInMethodButton(image: "ellipsis.rectangle", title: "DISCOVERING_VIEW_BUTTON_SIGN_IN_MANUAL", subtitle: "SIGN_IN_OPTION_ENTER_PASSWORD_SUBTITLE", table: table)
                }
                .listRowBackground(Color(colorScheme == .light ? UIColor.systemGray6 : UIColor.secondarySystemGroupedBackground))
            }
        }
        .padding(.top, -25)
        .background(colorScheme == .light ? .white : Color(UIColor.systemBackground))
        .scrollContentBackground(.hidden)
        .contentMargins(.horizontal, UIDevice.iPad ? 50 : 15, for: .scrollContent)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.gray, Color(UIColor.systemFill))
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    showingAlert.toggle()
                } label: {
                    Text("ACCOUNT_SETUP_CREATE_ACCOUNT_REBRAND", tableName: table)
                        .fontWeight(.semibold)
                }
                .padding(.bottom, UIDevice.iPad || UIDevice.HomeButtonCapability ? 5 : 60)
                .alert("Could Not Create Apple Account", isPresented: $showingAlert) {
                    Link("Learn More", destination: URL(string: "https://support.apple.com/en-us/101661")!)
                    Button("OK".localize(table: table)) {
                        dismiss()
                    }
                } message: {
                    Text("This \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model) has been used to create too many new Apple Accounts. Contact Apple Support to request another Apple Account to use with this \(UIDevice.IsSimulator ? "iPhoneSimulator" : UIDevice.current.model).")
                }
            }
        }
    }
}

// Apple Account Dotted Ring Header
struct animatedHeader: View {
    var body: some View {
        ZStack {
            dottedRing
            Image(systemName: "applelogo")
                .foregroundStyle(.blue)
                .font(.system(size: 25))
                .offset(y: -2)
        }
    }
    
    var dottedRing: some View {
        ZStack {
            Color.blue.opacity(0.5)
                .mask {
                    ZStack {
                        animatedDots(delay: 0.0)
                            .scaleEffect(0.4)
                            .rotationEffect(.degrees(2))
                        animatedDots(delay: 0.25)
                            .scaleEffect(0.3)
                            .rotationEffect(.degrees(12))
                    }
                }
        }
    }
}

// Animated Apple Account Dots
struct animatedDots: View {
    let delay: Double
    @State private var animating = false
    @State private var rotation = 0.0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ring
            .opacity(animating ? 1 : 0)
            .scaleEffect(animating ? 1 : 0.5)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                if rotation == 0.0 {
                    withAnimation(.easeInOut(duration: 1.0).delay(delay)) {
                        rotation += 90
                        animating = true
                    }
                }
            }
    }
    
    var ring: some View {
        Canvas { context, size in
            let dimensionOffset = size.width/2
            let icon = context.resolve(Image(systemName: "circle.fill"))
            var currentPoint = CGPoint(x: dimensionOffset - icon.size.width/0.2, y: 0)
            
            for _ in 0...20 {
                currentPoint = currentPoint.applying(.init(rotationAngle: Angle.degrees(18).radians))
                context.draw(icon, at: CGPoint(x: currentPoint.x + dimensionOffset, y: currentPoint.y + dimensionOffset))
            }
        }
        .frame(width: 360, height: 360)
    }
}

struct SignInMethodButton: View {
    let image: String
    let title: String
    let subtitle: String
    let table: String
    
    var body: some View {
        HStack {
            // Check if icon is an SF Symbol or an image asset
            if UIImage(systemName: image) != nil {
                Image(systemName: image)
                    .foregroundStyle(.blue)
                    .font(.system(size: 40))
                    .frame(width: 65)
            } else {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.blue)
                    .frame(width: 64)
            }
            
            VStack(alignment: .leading) {
                Text(title.localize(table: table))
                    .bold()
                Text(subtitle.localize(table: table))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(5)
            
            if UIImage(systemName: image) == nil {
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SelectSignInOptionView()
    }
}
