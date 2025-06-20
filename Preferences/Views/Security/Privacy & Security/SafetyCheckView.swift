//
//  SafetyCheckView.swift
//  Preferences
//
//  Settings > Privacy & Security > Safety Check
//

import SwiftUI

struct SafetyCheckView: View {
    @State private var showingAlert = false
    let table = "DigitalSeparationUI"
    
    var body: some View {
        CustomList(title: "SAFETY_CHECK".localize(table: table)) {
            Section {
                Placard(title: "SAFETY_CHECK".localize(table: table), icon: "com.apple.graphic-icon.safety-check", description: "WELCOME_DETAIL".localize(table: table), frameY: .constant(0.0), opacity: .constant(1.0))
            }
            
            Section {
                Button {
                    showingAlert.toggle()
                } label: {
                    HStack {
                        Image(systemName: "person.2.gobackward")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.blue)
                            .font(.title)
                            .padding(.leading, -5)
                            .padding(.trailing, 5)
                        VStack(alignment: .leading) {
                            Text("SAFETY_RESET", tableName: table)
                                .bold()
                            Text("SAFETY_RESET_CELL_DETAIL", tableName: table)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                                .font(.footnote)
                                .bold()
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
            
            Section {
                Button {
                    showingAlert.toggle()
                } label: {
                    HStack {
                        Image(systemName: "person.2.badge.gearshape.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.blue)
                            .font(.title2)
                            .padding(.leading, -5)
                            .padding(.trailing, 5)
                        VStack(alignment: .leading) {
                            Text("RESET_CUSTOMIZE", tableName: table)
                                .bold()
                            Text("SHARING_WELCOME_CELL_DETAIL", tableName: table)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                                .font(.footnote)
                                .bold()
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .alert("HSA2_NOT_REPAIRED_TITLE".localize(table: table), isPresented: $showingAlert) {
            Button("REMOTEUI_ERROR_CONFIRMATION".localize(table: table)) {}
        } message: {
            Text("HSA2_NOT_REPAIRED_DETAIL", tableName: table)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("QUICK_EXIT".localize(table: table)) {
                    exit(0)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SafetyCheckView()
    }
}
