//
//  DownloadedLanguagesView.swift
//  Preferences
//
//  Settings > Translate > Downloaded Languages
//

import SwiftUI

struct DownloadedLanguagesView: View {
    // Variables
    var originalLanguagesOrder = ["Arabic", "Chinese (Mandarin, Simplified)", "Chinese (Mandarin, Traditional)", "Dutch", "English (UK)", "English (US)", "French", "German", "Indonesian", "Italian", "Japanese", "Korean", "Polish", "Portuguese (Brazil)", "Russian", "Spanish (Spain)", "Thai", "Turkish", "Ukrainian", "Vietnamese"]
    @State private var downloaded: [String] = []
    @State private var languages = ["Arabic", "Chinese (Mandarin, Simplified)", "Chinese (Mandarin, Traditional)", "Dutch", "English (UK)", "English (US)", "French", "German", "Indonesian", "Italian", "Japanese", "Korean", "Polish", "Portuguese (Brazil)", "Russian", "Spanish (Spain)", "Thai", "Turkish", "Ukrainian", "Vietnamese"]
    
    var body: some View {
        CustomList(title: "Manage Languages") {
            Section(content: {}, footer: {
                Text("Both input and output languages must be downloaded to enable offline translation.")
            })
            
            if !downloaded.isEmpty {
                Section(content: {
                    ForEach($downloaded, id: \.self, editActions: .delete) { $language in
                        Text(language)
                    }
                    .onDelete { indexSet in
                        for index in indexSet{
                            languages.append(downloaded[index])
                        }
                        downloaded.remove(atOffsets: indexSet)
                        languages.sort { (lang1, lang2) in
                            guard let index1 = originalLanguagesOrder.firstIndex(of: lang1),
                                  let index2 = originalLanguagesOrder.firstIndex(of: lang2) else {
                                return false
                            }
                            return index1 < index2
                        }
                    }
                }, header: {
                    Text("Available Offline")
                })
            }
            
            Section(content: {
                ForEach(languages, id: \.self) { language in
                    Button(action: {
                        downloaded.append(language)
                        if let index = languages.firstIndex(of: language) {
                            languages.remove(at: index)
                        }
                    }, label: {
                        HStack {
                            Text(language)
                                .foregroundStyle(Color(UIColor.label))
                            Spacer()
                            Image(systemName: "arrow.down.circle")
                                .imageScale(.large)
                                .bold()
                        }
                    })
                }
            }, header: {
                Text("Languages Available for Download")
            })
        }
        .toolbar {
            if !downloaded.isEmpty {
                EditButton()
                    .bold()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DownloadedLanguagesView()
    }
}
