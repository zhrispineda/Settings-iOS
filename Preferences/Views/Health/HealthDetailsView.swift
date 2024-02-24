//
//  HealthDetailsView.swift
//  Preferences
//
//  Settings > Health > Health Details
//

import SwiftUI

struct HealthDetailsView: View {
    var body: some View {
        CustomList(title: "Health Details") {
            Section {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.white, .gray.gradient)
                    .listRowBackground(Color.clear)
                    .frame(maxWidth: .infinity)
            }
            
            Section {
                HText("First Name", status: "Not Set")
                HText("Last Name", status: "Not Set")
                CustomNavigationLink(title: "Date of Birth", status: "Not Set", destination: HealthDetailsDataView(title: "Date of Birth"))
                CustomNavigationLink(title: "Sex", status: "Not Set", destination: HealthDetailsDataView(title: "Sex"))
                CustomNavigationLink(title: "Blood Type", status: "Not Set", destination: HealthDetailsDataView(title: "Blood Type"))
                CustomNavigationLink(title: "Fitzpatrick Skin Type", status: "Not Set", destination: HealthDetailsDataView(title: "Fitzpatrick Skin Type"))
            }
            
            Section(content: {
                CustomNavigationLink(title: "Wheelchair", status: "Not Set", destination: HealthDetailsDataView(title: "Wheelchair"))
            }, footer: {
                Text("Track pushes instead of steps on Apple Watch in the Activity app, and in wheelchair workouts in the Workout app, and record them to Health. When this setting is on, your iPhone stops tracking steps.")
            })
            
            Section(content: {
                CustomNavigationLink(title: "Medications That Affect Heart Rate", status: "0", destination: HealthDetailsDataView(title: "Medications That Affect HeartRate"))
            }, footer: {
                Text("Beta blockers or calcium channel blockers can limit your heart rate. Apple Watch can take this into account when estimating your cardio fitness.\n\nChanging this setting does not affect existing data but could change your future cardio fitness predictions.")
            })
        }
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    NavigationStack {
        HealthDetailsView()
    }
}
