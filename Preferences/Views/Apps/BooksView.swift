//
//  BooksView.swift
//  Preferences
//
//  Settings > Apps > Books
//

import SwiftUI

struct BooksView: View {
    @AppStorage("ReadingMenuPosition") private var readingMenuPosition = "Right"
    @AppStorage("AutoHyphenationEnabled") private var autoHyphenation = true
    @AppStorage("BothMarginsAdvanceEnabled") private var bothMarginsAdvance = false
    @AppStorage("AutoInvertImages") private var autoInvertImages = true
    @AppStorage("ShowStatusBarBooks") private var showStatusBar = false
    @AppStorage("PageNavigationOption") private var pageNavigation = "Slide"
    @AppStorage("ReadingGoalsEnabled") private var readingGoals = true
    @AppStorage("IncludePdfGoals") private var includePdfGoals = false
    @AppStorage("BookStoreEnabled") private var bookStore = true
    @AppStorage("SkipForward") private var skipForward = "15 seconds"
    @AppStorage("SkipBack") private var skipBack = "15 seconds"
    @AppStorage("ExternalControl") private var externalControl = "Skip Forward/Back"
    @State private var showingClearDataAlert = false
    @State private var dataCleared = false
    @State private var showingPermissionResetAlert = false
    @State private var permissionsCleared = false
    @State private var showingResetIdAlert = false
    @State private var idReset = false
    @State private var showingSheet = false
    let externalControlOptions = ["Next/Previous", "Skip Forward/Back"]
    let path = "/System/Library/PreferenceBundles/iBooksSettings.bundle"
    let table = "Settings"
    
    var body: some View {
        CustomList(title: "Books".localized(path: path, table: table), topPadding: true) {
            PermissionsView(appName: "Books".localized(path: path, table: table), background: true, cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Toggle("Home".localized(path: path, table: table), isOn: .constant(false))
                Toggle("iCloud Drive".localized(path: path, table: table), isOn: .constant(false))
            } header: {
                Text("Syncing".localized(path: path, table: table))
            } footer: {
                Text("To enable syncing across devices, sign in to iCloud and turn on iCloud Drive in Settings.".localized(path: path, table: table))
            }
            .disabled(true)
            
            Section("Reading Menu Position".localized(path: path, table: table)) {
                HStack {
                    Spacer()
                    Button {
                        readingMenuPosition = "Left"
                    } label: {
                        VStack(spacing: 15) {
                            Image("LeftAlignUI-iPhone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                                .padding(.top, 5)
                            Text("Left", tableName: table)
                                .padding(.bottom, -5)
                            Image(systemName: readingMenuPosition == "Left" ? "checkmark.circle.fill": "circle")
                                .foregroundStyle(readingMenuPosition == "Left" ? Color.white : .blue, .blue)
                                .font(.title2)
                        }
                    }
                    .buttonStyle(MenuPositionButton())
                    
                    Spacer()
                    
                    Button {
                        readingMenuPosition = "Right"
                    } label: {
                        VStack(spacing: 15) {
                            Image("RightAlignUI-\(UIDevice.current.model)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                                .padding(.top, 5)
                            Text("Right", tableName: table)
                                .padding(.bottom, -5)
                            Image(systemName: readingMenuPosition == "Right" ? "checkmark.circle.fill": "circle")
                                .foregroundStyle(readingMenuPosition == "Right" ? Color.white : .blue, .blue)
                                .font(.title2)
                        }
                    }
                    .buttonStyle(MenuPositionButton())
                    
                    Spacer()
                }
            }
            
            Section("Reading".localized(path: path, table: table)) {
                Toggle("Auto-hyphenation".localized(path: path, table: table), isOn: $autoHyphenation)
                Toggle(isOn: $bothMarginsAdvance) {
                    Text("Both Margins Advance".localized(path: path, table: table))
                    Text("Allow tapping either margin to advance the page, or to move the line guide forward when enabled in the reading menu.".localized(path: path, table: table))
                }
                Toggle(isOn: $autoInvertImages) {
                    Text("Automatically Invert Images".localized(path: path, table: table))
                    Text("In darker themes, adjust black and white images to improve contrast.".localized(path: path, table: table))
                }
                Toggle(isOn: $showStatusBar) {
                    Text("Show Status Bar".localized(path: path, table: table))
                    Text(UIDevice.iPhone ? "Always display current time, battery level, and other iPhone status info while reading.".localized(path: path, table: table) : "Always display current time, battery level, and other iPad status info while reading.".localized(path: path, table: table))
                }
                SettingsLink("Page Navigation".localized(path: path, table: table), status: pageNavigation.localized(path: path, table: table), destination: SelectOptionList("Page Navigation", options: ["Slide", "Curl", "Fast Fade", "Scroll"], selectedBinding: $pageNavigation, table: table))
            }
            
            Section {
                Toggle("Reading Goals".localized(path: path, table: table), isOn: $readingGoals)
                if readingGoals {
                    Toggle("Include PDFs".localized(path: path, table: table), isOn: $includePdfGoals)
                }
            } header: {
                Text("Reading Goals".localized(path: path, table: table))
            } footer: {
                Text(readingGoals ? "Show time spent reading and other achievements in Apple Books. Include time spent reading PDFs".localized(path: path, table: table) : "Show time spent reading and other achievements in Apple Books.".localized(path: path, table: table))
            }
            
            Section {
                Button("Clear Reading Goals Data".localized(path: path, table: table)) {
                    showingClearDataAlert.toggle()
                }
                .confirmationDialog("Clear Reading Goals Data".localized(path: path, table: table), isPresented: $showingClearDataAlert) {
                    Button("Clear Reading Goals Data".localized(path: path, table: table), role: .destructive) {
                        dataCleared.toggle()
                    }
                } message: {
                    Text("Do you want to clear reading goals data from all of your devices using this iCloud account?".localized(path: path, table: table))
                }
            } footer: {
                Text("Time spent reading and reading streak data will be cleared the next time you open Apple Books.".localized(path: path, table: table))
            }
            .disabled(dataCleared)
            
            Section {
                Toggle("Book Store".localized(path: path, table: table), isOn: $bookStore)
            } header: {
                Text("Searching".localized(path: path, table: table))
            } footer: {
                Text("Include Book Store results when searching.".localized(path: path, table: table))
            }
            
            Section {
                SettingsLink("Skip Forward".localized(path: path, table: table), status: skipForward.localized(path: path, table: table), destination: SelectOptionList("Skip Forward", options: ["10 seconds", "15 seconds", "30 seconds", "45 seconds", "60 seconds"], selectedBinding: $skipForward, table: table))
                SettingsLink("Skip Back".localized(path: path, table: table), status: skipBack.localized(path: path, table: table), destination: SelectOptionList("Skip Back", options: ["10 seconds", "15 seconds", "30 seconds", "45 seconds", "60 seconds"], selectedBinding: $skipBack, table: table))
            } header: {
                Text("Audiobooks".localized(path: path, table: table))
            } footer: {
                Text("Set the number of seconds to skip when you swipe the cover or tap the skip button.".localized(path: path, table: table))
            }
            
            Section {
                Picker("External Controls".localized(path: path, table: table), selection: $externalControl) {
                    ForEach(externalControlOptions, id: \.self) { option in
                        Text(option.localized(path: path, table: table))
                    }
                }
                .labelsHidden()
                .pickerStyle(.inline)
            } header: {
                Text("External Controls".localized(path: path, table: table))
            } footer: {
                Text("Headphones and car controls can be used to play the next/previous chapter, or skip forward/back within the audiobook.".localized(path: path, table: table))
            }
            
            Section {
                Button("Reset Access to Online Content".localized(path: path, table: table)) {
                    showingPermissionResetAlert.toggle()
                }
                .confirmationDialog("Clear permission for books to access publisher\u{2019}s content from the Internet.".localized(path: path, table: table), isPresented: $showingPermissionResetAlert) {
                    Button("Reset Access to Online Content".localized(path: path, table: table), role: .destructive) {
                        permissionsCleared.toggle()
                    }
                } message: {
                    Text("Clear permission for books to access publisher\u{2019}s content from the Internet.".localized(path: path, table: table))
                }
            } header: {
                Text("Online Content & Privacy".localized(path: path, table: table))
            } footer: {
                Text("Clear permission for books to access publisher\u{2019}s content from the Internet.".localized(path: path, table: table))
            }
            
            Section {
                Button("Reset Identifier".localized(path: path, table: table)) {
                    showingResetIdAlert.toggle()
                }
                .confirmationDialog("Reset Identifier".localized(path: path, table: table), isPresented: $showingResetIdAlert) {
                    Button("Reset Identifier".localized(path: path, table: table), role: .destructive) {
                        idReset.toggle()
                    }
                } message: {
                    Text("Reset Identifier".localized(path: path, table: table))
                }
            } footer: {
                Text("\("Reset the identifier used to report aggregate app usage statistics to Apple.".localized(path: path, table: table)) [\("See how your data is managed…".localized(path: path, table: table))](pref://)")
            }
            
            NavigationLink("Acknowledgements".localized(path: path, table: table)) {
                Text("")
                    .navigationTitle("Acknowledgements".localized(path: path, table: table))
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingKitView(bundleID: "com.apple.onboarding.ibooks")
                .ignoresSafeArea()
        }
    }
}

struct MenuPositionButton: ButtonStyle {
    func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    NavigationStack {
        BooksView()
    }
}
