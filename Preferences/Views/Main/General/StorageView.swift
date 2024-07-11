//
//  StorageView.swift
//  Preferences
//
//  Settings > General > [Device] Storage
//

import SwiftUI
import Charts

struct StorageView: View {
    // Variables
    @State private var searchText = String()
    
    // Data
    struct StorageData {
        struct Storage: Identifiable {
            let type: String
            let usage: Double
            var id: String { type }
        }
        
        @MainActor static var currentStorage: [Storage] = [
            .init(type: "Applications", usage: 33.32),
            .init(type: UIDevice().systemName, usage: 9.97),
            .init(type: "System Data", usage: 22.33)
        ]
    }
    
    var body: some View {
        CustomList(title: "\(Device().model) Storage") {
            // Graph Section
            Section {
                VStack {
                    HStack {
                        Text("\(Device().model)")
                        Spacer()
                        Text("65.62 GB of 256 GB used")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Chart(StorageData.currentStorage, id: \.type) { data in
                        Plot {
                            BarMark(x: .value("Storage Size", data.usage))
                        }
                        .foregroundStyle(by: .value("Data Type", data.type))
                    }
                    .chartPlotStyle { plotArea in
                        ZStack {
                            Color(UIColor.systemGroupedBackground)
                            Text("190.30 GB")
                                .font(.subheadline)
                                .foregroundStyle(Color["Label"])
                                .padding(.leading, 70)
                            plotArea
                        }
                        .cornerRadius(5.0)
                    }
                    .chartForegroundStyleScale([
                        "Applications" : Color.red,
                        UIDevice().systemName : Color(UIColor.systemGray2),
                        "System Data": Color(UIColor.systemGray4)])
                    .chartXAxis(.hidden)
                    .chartXScale(domain: 0...256)
                    .frame(height: 45)
                }
            }
            
            Section {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    NavigationStack {
        StorageView()
    }
}
