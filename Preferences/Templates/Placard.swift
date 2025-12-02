import SwiftUI

/// A `VStack` container that is displayed at the top of lists to summarize common controls to be expected below.
///
/// ```swift
/// Placard(
///     title: "General",
///     icon: "com.apple.graphic-icon.gear",
///     description: "Manage common options.",
///     isVisible: $isVisible
/// )
/// ```
///
/// - Parameter title: The `String` to display as the navigation title.
/// - Parameter icon: The `String` identifier of an icon.
/// - Parameter description: The `String` to display as the description below the placard title.
/// - Parameter isVisible: The `Binding` `Bool` value to use for displaying or hiding the navigationTitle.
struct Placard: View {
    @State private var opacity = 0.0
    @State private var frameY = 0.0
    var title: String
    var icon = ""
    var description = ""
    var beta = false
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topLeading) {
                IconView(icon)
                    .scaleEffect(2)
                    .padding([.top, .leading], 15)
                
                if beta {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 40, height: 15)
                            .foregroundStyle(.black)
                        Text("BETA")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .offset(x: 20, y: 50)
                }
            }
            .accessibilityHidden(true)
            
            Text(title)
                .font(.title2.bold())
                .padding(.top, 20)
                .padding(.bottom, -4)
            Text(.init(description))
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.secondary)
                .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .fontWeight(.semibold)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
        .overlay {
            GeometryReader { geo in
                Color.clear
                    .onChange(of: geo.frame(in: .scrollView).minY) {
                        frameY = geo.frame(in: .scrollView).minY
                        opacity = (frameY - 50) / -30
                    }
            }
        }
        .onAppear { isVisible = false }
        .onDisappear { isVisible = true }
    }
}

#Preview {
    @Previewable @State var isVisible = false
    
    NavigationStack {
        CustomList(title: "General") {
            Section {
                Placard(
                    title: "General",
                    icon: "com.apple.graphic-icon.gear",
                    description: "Manage your overall setup and preferences for iPad, such as software updates, AirDrop, and more.",
                    isVisible: $isVisible
                )
            }
            
            Section {
                ForEach(0...20, id: \.self) { item in
                    Text("\(item)")
                }
            }
        }
    }
}
