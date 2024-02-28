//
//  HoverTextFontView.swift
//  Preferences
//
//  Settings > Accessibility > Hover Text > Font
//

import SwiftUI

struct HoverTextFontView: View {
    // Variables
    @State private var selected = "Default"
    let options = ["Academy Engraved LET", "Al Nile", "American Typewriter", "Apple Color Emoji", "Apple SD Gothic Neo", "Apple Symbols", "Arial", "Arial Hebrew", "Arial Rounded MT Bold", "Avenir", "Avenir Next", "Avenir Next Condensed", "Baskerville", "Bodoni 72", "Bodoni 72 Oldstyle", "Bodoni 72 Smallcaps", "Bradley Hand", "Chalkboard SE", "Chalkduster", "Charter", "Cochin", "Copperplate", "Courier New", "Damascus", "Devanagari Sangam MN", "Didot", "DIN Alternate", "DIN Condensed", "Euphemia UCAS", "Farah", "Futura", "Galvji", "Geeza Pro", "Georgia", "Gill Sans", "Grantha Sangam MN", "Helvetica", "Helvetica Neue", "Hiragino Mincho ProN", "Hiragino Sans", "Hoefler Text", "Impact", "Kailasa", "Kefa", "Khmer Sangam MN", "Kohinoor Bangla", "Kohinoor Devanagari", "Kohinoor Gujarati", "Kohinoor Telugu", "Lao Sangam MN", "Malayalam Sangam MN", "Marker Felt", "Menlo", "Mishafi", "Mukta Mahee", "Myanmar Sangam MN", "Noteworthy", "Noto Nastaliq Urdu", "Noto Sans Kannada", "Noto Sans Myanmar", "Noto Sans Oriya", "Optima", "Palatino", "Papyrus", "Party LET", "PingFang HK", "PingFang SC", "PingFang TC", "Rockwell", "Savoye LET", "Sinhala Sangam MN", "Snell Roundhand", "STIX Two Math", "STIX Two Text", "Symbol", "Tamil Sangman MN", "Thonburi", "Times New Roman", "Trebuchet MS", "Verdana", "Zapf Dingbats", "Zapfino"]
    
    var body: some View {
        CustomList(title: "Font") {
            ForEach(options, id: \.self) { font in
                Button(action: {
                    selected = font
                }, label: {
                    HStack {
                        Text(font)
                            .font(Font.custom(font, size: 18))
                            .foregroundStyle(Color["Label"])
                        Spacer()
                        Image(systemName: "checkmark")
                            .opacity(selected == font ? 1 : 0)
                    }
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        HoverTextFontView()
    }
}
