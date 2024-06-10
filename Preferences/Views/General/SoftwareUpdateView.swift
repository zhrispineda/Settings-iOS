//
//  SoftwareUpdateView.swift
//  Preferences
//
//  Settings > General > Software Update
//

import SwiftUI

struct SoftwareUpdateView: View {
    @State private var checkingForUpdates = false
    @State private var updateCheckFailed = false
    
    var body: some View {
        CustomList(title: "Software Update") {
            Section {
                CustomNavigationLink(title: "Automatic Updates", status: "On", destination: AutomaticUpdateView())
                
                if !checkingForUpdates && !updateCheckFailed {
                    CustomNavigationLink(title: "Beta Updates", status: "\(UIDevice().systemName) 17 Developer Beta", destination: BetaUpdatesView())
                }
            }
            
            HStack {
                Spacer()
                VStack {
                    if checkingForUpdates {
                        ProgressView()
                            .controlSize(.large)
                            .padding(.bottom, 1)
                    } else {
                        if updateCheckFailed {
                            Text("Unable to Check for Update").fontWeight(.bold)
                                .font(.system(size: 20))
                        } else {
                            Text("\(UIDevice().systemName) \(UIDevice().systemVersion)")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                        }
                    }
                    
                    withAnimation {
                        Text(checkingForUpdates ? "Checking for Update..." : (updateCheckFailed ? "An error occurred while checking for a software update." : "\(UIDevice().systemName) is up to date"))
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.bottom, 10)
                    }
                    
                    if !checkingForUpdates && updateCheckFailed {
                        Button("Try Again", action: {})
                            .font(.subheadline)
                    }
                }
                Spacer()
            }
            .listRowBackground(Color.clear)
            .padding(.top, 200)
            .onAppear(perform: {
                checkUpdate(withDelay: Double.random(in: 1.0...5.0))
            })
        }
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
