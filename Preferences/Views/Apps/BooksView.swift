//
//  BooksView.swift
//  Preferences
//
//  Settings > Apps > Books
//

import SwiftUI

struct BooksView: View {
    // Variables
    let table = "iBooksSettings"
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
    
    var body: some View {
        CustomList(title: "Books", topPadding: true) {
            PermissionsView(appName: "Books", background: true, cellular: false, location: false, notifications: false, cellularEnabled: .constant(false))
            
            Section {
                Toggle("Home".localize(table: table), isOn: .constant(false))
                Toggle("iCloud Drive".localize(table: table), isOn: .constant(false))
            } header: {
                Text("Syncing", tableName: table)
            } footer: {
                Text("To enable syncing across devices, sign in to iCloud and turn on iCloud Drive in Settings.", tableName: table)
            }
            .disabled(true)
            
            Section("Reading Menu Position".localize(table: table)) {
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
            
            Section("Reading".localize(table: table)) {
                Toggle("Auto-hyphenation".localize(table: table), isOn: $autoHyphenation)
                Toggle(isOn: $bothMarginsAdvance) {
                    Text("Both Margins Advance", tableName: table)
                    Text("Allow tapping either margin to advance the page, or to move the line guide forward when enabled in the reading menu.", tableName: table)
                }
                Toggle(isOn: $autoInvertImages) {
                    Text("Automatically Invert Images", tableName: table)
                    Text("In darker themes, adjust black and white images to improve contrast.", tableName: table)
                }
                Toggle(isOn: $showStatusBar) {
                    Text("Show Status Bar", tableName: table)
                    Text(UIDevice.iPhone ? "Always display current time, battery level, and other iPhone status info while reading." : "Always display current time, battery level, and other iPad status info while reading.", tableName: table)
                }
                CustomNavigationLink(title: "Page Navigation".localize(table: table), status: pageNavigation.localize(table: table), destination: SelectOptionList(title: "Page Navigation", options: ["Slide", "Curl", "Fast Fade", "Scroll"], selectedBinding: $pageNavigation, table: table))
            }
            
            Section {
                Toggle("Reading Goals".localize(table: table), isOn: $readingGoals)
                if readingGoals {
                    Toggle("Include PDFs".localize(table: table), isOn: $includePdfGoals)
                }
            } header: {
                Text("Reading Goals", tableName: table)
            } footer: {
                Text(readingGoals ? "Show time spent reading and other achievements in Apple Books. Include time spent reading PDFs" : "Show time spent reading and other achievements in Apple Books.", tableName: table)
            }
            
            Section {
                Button("Clear Reading Goals Data".localize(table: table)) {
                    showingClearDataAlert.toggle()
                }
                .confirmationDialog("Clear Reading Goals Data".localize(table: table), isPresented: $showingClearDataAlert) {
                    Button("Clear Reading Goals Data".localize(table: table), role: .destructive) {
                        dataCleared.toggle()
                    }
                } message: {
                    Text("Do you want to clear reading goals data from all of your devices using this iCloud account?", tableName: table)
                }
            } footer: {
                Text("Time spent reading and reading streak data will be cleared the next time you open Apple Books.", tableName: table)
            }
            .disabled(dataCleared)
            
            Section {
                Toggle("Book Store".localize(table: table), isOn: $bookStore)
            } header: {
                Text("Searching", tableName: table)
            } footer: {
                Text("Include Book Store results when searching.", tableName: table)
            }
            
            Section {
                CustomNavigationLink(title: "Skip Forward".localize(table: table), status: skipForward.localize(table: table), destination: SelectOptionList(title: "Skip Forward", options: ["10 seconds", "15 seconds", "30 seconds", "45 seconds", "60 seconds"], selectedBinding: $skipForward, table: table))
                CustomNavigationLink(title: "Skip Back".localize(table: table), status: skipBack.localize(table: table), destination: SelectOptionList(title: "Skip Back", options: ["10 seconds", "15 seconds", "30 seconds", "45 seconds", "60 seconds"], selectedBinding: $skipBack, table: table))
            } header: {
                Text("Audiobooks", tableName: table)
            } footer: {
                Text("Set the number of seconds to skip when you swipe the cover or tap the skip button.", tableName: table)
            }
            
            Section {
                Picker("External Controls".localize(table: table), selection: $externalControl) {
                    ForEach(externalControlOptions, id: \.self) { option in
                        Text(option.localize(table: table))
                    }
                }
                .labelsHidden()
                .pickerStyle(.inline)
            } header: {
                Text("External Controls", tableName: table)
            } footer: {
                Text("Headphones and car controls can be used to play the next/previous chapter, or skip forward/back within the audiobook.", tableName: table)
            }
            
            Section {
                Button("Reset Access to Online Content".localize(table: table)) {
                    showingPermissionResetAlert.toggle()
                }
                .confirmationDialog("Clear permission for books to access publisher\u{2019}s content from the Internet.".localize(table: table), isPresented: $showingPermissionResetAlert) {
                    Button("Reset Access to Online Content".localize(table: table), role: .destructive) {
                        permissionsCleared.toggle()
                    }
                } message: {
                    Text("Clear permission for books to access publisher\u{2019}s content from the Internet.", tableName: table)
                }
            } header: {
                Text("Online Content & Privacy", tableName: table)
            } footer: {
                Text("Clear permission for books to access publisher\u{2019}s content from the Internet.", tableName: table)
            }
            
            Section {
                Button("Reset Identifier".localize(table: table)) {
                    showingResetIdAlert.toggle()
                }
                .confirmationDialog("Reset Identifier".localize(table: table), isPresented: $showingResetIdAlert) {
                    Button("Reset Identifier".localize(table: table), role: .destructive) {
                        idReset.toggle()
                    }
                } message: {
                    Text("Reset Identifier", tableName: table)
                }
            } footer: {
                Text("Reset the identifier used to report aggregate app usage statistics to Apple.", tableName: table) + Text(" [\("BUTTON_TITLE".localize(table: "AppleBooks"))](pref://)")
            }
            
            NavigationLink("Acknowledgements".localize(table: table)) {
                Text(String())
                    .navigationTitle("Acknowledgements".localize(table: table))
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .onOpenURL { url in
            if url.scheme == "pref" {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet) {
            OnBoardingView(table: "AppleBooks")
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
