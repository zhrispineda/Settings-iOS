//
//  DownloadedLanguagesView.swift
//  Preferences
//
//  Settings > Apps > Translate > Downloaded Languages
//

import SwiftUI

struct DownloadedLanguagesView: View {
    // Variables
    var originalLanguagesOrder = ["Arabic", "Chinese (Mandarin, Simplified)", "Chinese (Mandarin, Traditional)", "Dutch", "English (UK)", "English (US)", "French", "German", "Indonesian", "Italian", "Japanese", "Korean", "Polish", "Portuguese (Brazil)", "Russian", "Spanish (Spain)", "Thai", "Turkish", "Ukrainian", "Vietnamese"]
    @State private var downloaded: [String] = []
    @State private var languages = ["Arabic", "Chinese (Mandarin, Simplified)", "Chinese (Mandarin, Traditional)", "Dutch", "English (UK)", "English (US)", "French", "German", "Indonesian", "Italian", "Japanese", "Korean", "Polish", "Portuguese (Brazil)", "Russian", "Spanish (Spain)", "Thai", "Turkish", "Ukrainian", "Vietnamese"]
    let table = "TranslationUI"
    
    var body: some View {
        CustomList(title: "Manage Languages".localize(table: table)) {
            Section {} footer: {
                Text("TRANSLATIONS_DOWNLOAD_LANGUAGE_PAIR_TITLE", tableName: table)
            }
            
            if !downloaded.isEmpty {
                Section {
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
                } header: {
                    Text("TRANSLATIONS_INSTALLED_TITLE", tableName: table)
                }
            }
            
            Section {
                ForEach(languages, id: \.self) { language in
                    Button {
                        downloaded.append(language)
                        if let index = languages.firstIndex(of: language) {
                            languages.remove(at: index)
                        }
                    } label: {
                        HStack {
                            Text(language)
                                .foregroundStyle(.text)
                            Spacer()
                            Image(systemName: "arrow.down.circle")
                                .imageScale(.large)
                                .bold()
                        }
                    }
                }
            } header: {
                Text("TRANSLATIONS_DOWNLOADABLE_TITLE", tableName: table)
            }
        }
        .toolbar {
            if !downloaded.isEmpty {
                //EditButton()
                    //.bold()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DownloadedLanguagesView()
    }
}
