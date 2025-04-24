//
//  OtherNetworkView.swift
//  Preferences
//
//  Settings > Wi-Fi > Other...
//

import SwiftUI

struct OtherNetworkView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    @FocusState private var networkFocused: Bool
    @State private var networkName = ""
    @State private var security = "kWFLocSecurityWPA2WPA3Title"
    @State private var username = ""
    @State private var password = ""
    @State var status = "kWFLocOtherNetworksPrompt"
    let table = "WiFiKitUILocalizableStrings"
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("kWFLocOtherNetworkNameTitle", tableName: table)
                        TextField("kWFLocOtherNetworkNamePlaceholder".localize(table: table), text: $networkName)
                            .focused($networkFocused)
                            .padding(.leading, 10)
                            .onAppear {
                                networkFocused = true
                            }
                    }
                }
                .onAppear {
                    setNavigationPrompt()
                }
                
                Section {
                    CustomNavigationLink("kWFLocOtherNetworkSecurityTitle".localize(table: table), status: security.localize(table: table), destination: SecurityView(security: $security))
                    if security.contains("Enterprise") {
                        HStack {
                            Text("kWFLocOtherNetworkUsernameTitle", tableName: table)
                            TextField("", text: $username)
                                .padding(.leading, 10)
                        }
                    }
                    if security != "kWFLocSecurityNoneTitle" {
                        HStack {
                            Text("kWFLocOtherNetworkPasswordTitle", tableName: table)
                            SecureField("", text: $password)
                                .padding(.leading, 10)
                        }
                    }
                }
            }
            .navigationTitle("kWFLocOtherNetworksTitle".localize(table: table))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("kWFLocAdhocJoinCancelButton", tableName: table)
                            .foregroundStyle(Color.accentColor)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: {
                        Text("kWFLocOtherNetworksJoinButton", tableName: table)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.accentColor)
                    }
                    .disabled(networkName.count < 1 || (password.count < 8 && username.isEmpty) || username.count < 1 && password.count < 1)
                }
            }
        }
    }
    
    // Workaround for accessing UINavigationItem prompt
    private func setNavigationPrompt() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first,
              let rootVC = window.rootViewController else {
            return
        }
        
        if let presentedVC = getPresentedViewController(from: rootVC) {
            if let navigationController = getNavigationController(from: presentedVC) {
                navigationController.topViewController?.navigationItem.prompt = status.localize(table: table)
            }
        }
    }
    
    private func getPresentedViewController(from viewController: UIViewController) -> UIViewController? {
        var currentVC = viewController
        while let presentedVC = currentVC.presentedViewController {
            currentVC = presentedVC // Ensures the selected view controller is from OtherNetworkView (top view) when presented as a popover
        }
        return currentVC
    }
    
    private func getNavigationController(from viewController: UIViewController) -> UINavigationController? {
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for child in viewController.children {
            if let navigationController = getNavigationController(from: child) {
                return navigationController
            }
        }
        
        return nil
    }
}

#Preview {
    NavigationStack {
        OtherNetworkView()
    }
}
