//
//  SoftwareUpdateView.swift
//  Preferences
//
//  Settings > General > Software Update
//

import SwiftUI

struct SoftwareUpdateView: View {
    @State private var checkingForUpdates = false
    
    var body: some View {
        GeometryReader { geometry in
            CustomList(title: "Software Update") {
                Section {
                    CustomNavigationLink(title: "Automatic Updates", status: "On", destination: AutomaticUpdateView())
                    
                    //                if !checkingForUpdates && !updateCheckFailed {
                    //                    CustomNavigationLink(title: "Beta Updates", status: "\(UIDevice().systemName) 18 Developer Beta", destination: BetaUpdatesView())
                    //                }
                }
                VStack {
                    if checkingForUpdates {
                        ProgressView()
                            .controlSize(.large)
                            .padding(.bottom, 1)
                    }
                    
                    if checkingForUpdates {
                        withAnimation {
                            Text("Checking for Update...")
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                                .padding(.bottom, 10)
                        }
                    } else {
                        ContentUnavailableView(
                            "\(UIDevice().systemName) \(UIDevice().systemVersion)",
                            systemImage: "",
                            description: Text("\(UIDevice().systemName) is up to date")
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .frame(height: geometry.size.height/1.4)
                .onAppear {
                    checkUpdate(withDelay: Double.random(in: 0.1...5.0))
                }
            }
        }
        .refreshable {}
    }
    
    func checkUpdate(withDelay delay: Double) {
        checkingForUpdates = true
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
                checkingForUpdates.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SoftwareUpdateView()
    }
}
