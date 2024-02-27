//
//  SpeakSelectionVoiceDetailView.swift
//  Preferences
//
//  Settings > Accessibility > Spoken Content > Voices > [Voice]
//

import SwiftUI

struct SpeakSelectionVoiceDetailView: View {
    // Variables
    var title = "English"
    
    // English
    let enUSVoices = ["Agnes", "Alex", "Allison", "Ava", "Bruce", "Evan", "Fred", "Joelle", "Junior", "Kathy", "Nathan", "Nicky", "Noelle", "Ralph", "Samantha", "Siri", "Susan", "Tom", "Vicki", "Victoria", "Zoe"]
    let enAUVoices = ["Karen", "Lee", "Matilda", "Siri"]
    let enINVoices = ["Isha", "Rishi", "Sangeeta", "Siri", "Veena"]
    let enIRVoices = ["Moira", "Siri"]
    let enSUKVoices = ["Fiona"]
    let enSAVoices = ["Siri", "Tessa"]
    let enUKVoices = ["Daniel", "Jamie", "Kate", "Oliver", "Serena", "Siri", "Stephanie"]
    let noveltyVoices = ["Albert", "Bad News", "Bahh", "Bells", "Boing", "Bubbles", "Cellos", "Good News", "Jupiter", "Jester", "Organ", "Superstar", "Trinoids", "Whisper", "Wobble", "Zarvox"]
    
    // Arabic
    let arabicVoices = ["Laila", "Majed", "Mariam", "Tarik"]
    
    // Bangla
    let banglaVoices = ["Piya"]
    
    // Basque
    let basqueVoices = ["Miren"]
    
    // Bhojpuri
    let bhojpuriVoices = ["Jaya"]
    
    // Bulgarian
    let bulgarianVoices = ["Daria"]
    
    // Catalan
    let catalanVoices = ["Jordi", "Montse"]
    let valencianVoices = ["Pau"]
    
    // Chinese
    let chineseMainlandVoices = ["Binbin", "Bobo", "Han", "Lanlan", "Lili", "Lilian", "Lisheng", "Shanshan", "Shasha", "Taotao", "Tiantian", "Tingting", "Yu-shu", "Yue"]
    let chineseHongKongVoices = ["Aasing", "Sinji"]
    let chineseLiaoningVoices = ["Dongmei"]
    let chineseShaanxiVoices = ["Haohao"]
    let chineseSichuanVoices = ["Panpan"]
    let chineseTaiwanVoices = ["Meijia"]
    
    // Croatian
    let croatianVoices = ["Lana"]
    
    // Czech
    let czechVoices = ["Iveta", "Zuzana"]
    
    // Danish
    let danishVoices = ["Magnus", "Sara"]
    
    // Dutch
    let dutchBelgiumVoices = ["Ellen"]
    let dutchNetherlands = ["Claire", "Xander"]
    
    // Finnish
    let finnishVoices = ["Onni", "Satu"]
    
    // French
    let frenchBelgiumVoices = ["Aude"]
    let frenchCanadaVoices = ["Amélie", "Chantal", "Nicolas"]
    let frenchFranceVoices = ["Audrey", "Aurélie", "Thomas"]
    
    // Galician
    let galicianVoices = ["Carmela"]
    
    // German
    let germanVoices = ["Anna", "Markus", "Petra", "Viktor", "Yannick"]
    
    // Greek
    let greekVoices = ["Melina", "Nikos"]
    
    // Hebrew
    let hebrewVoices = ["Carmit"]
    
    // Hindi
    let hindiVoices = ["Kiyara", "Lekha", "Neel"]
    
    // Hungarian
    let hungarianVoices = ["Tünde"]
    
    // Indonesian
    let indonesianVoices = ["Damayanti"]
    
    // Italian
    let italianVoices = ["Alice", "Emma", "Federica", "Luca", "Paola"]
    
    // Japanese
    let japaneseVoices = ["Kyoko", "Otoya"]
    
    // Kannada
    let kannadaVoices = ["Soumya"]
    
    // Korean
    let koreanVoices = ["Jian", "Minsu", "Sora", "Suhyun", "Yuna"]
    
    // Malay
    let malayVoices = ["Amira"]
    
    // Marathi
    let marathiVoices = ["Ananya"]
    
    // Norwegian Bokmål
    let norwegianVoices = ["Henrik", "Nora"]
    
    // Persian
    let persianVoices = ["Dariush"]
    
    // Polish
    let polishVoices = ["Ewa", "Krysztof", "Zosia"]
    
    // Portuguese
    let portugueseBrazilVoices = ["Felipe", "Fernanda", "Luciana"]
    let portuguesePortugalVoices = ["Catarina", "Joana", "Joaquim"]
    
    // Romanian
    let romanianVoices = ["Ioana"]
    
    // Russian
    let russianVoices = ["Katya", "Milena", "Yuri"]
    
    // Shanghainese
    let shanghaineseVoices = ["Nannan"]
    
    // Slovak
    let slovakVoices = ["Laura"]
    
    // Slovenian
    let slovenianVoices = ["Tina"]
    
    // Spanish
    let spanishArgentinaVoices = ["Diego", "Isabela"]
    let spanishChileVoices = ["Francisca"]
    let spanishColumbiaVoices = ["Carlos", "Jimena", "Soledad"]
    let spanishMexicoVoices = ["Angélica", "Juan", "Paulina"]
    let spanishSpainVoices = ["Jorge", "Marisol", "Mónica"]
    
    // Swedish
    let swedishVoices = ["Alva", "Klara", "Oskar"]
    
    // Tamil
    let tamilVoices = ["Vani"]
    
    // Telugu
    let teluguVoices = ["Geeta"]
    
    // Thai
    let thaiVoices = ["Kanya", "Narisa"]
    
    // Turkish
    let turkishVoices = ["Cem", "Yelda"]
    
    // Ukrainian
    let ukrainianVoices = ["Lesya"]
    
    // Vietnamese
    let vietnameseVoices = ["Linh"]
    
    @State private var selectedVoice = "Samantha"
    
    var body: some View {
        CustomList(title: title) {
            switch title {
            case "English":
                Section(content: {
                    ForEach(enUSVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (US)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("\nEnglish (US)")
                })
                
                Section(content: {
                    ForEach(enAUVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (Australia)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("English (Australia)")
                })
                
                Section(content: {
                    ForEach(enINVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (India)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("English (India)")
                })
                
                Section(content: {
                    ForEach(enIRVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (Ireland)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("English (Ireland)")
                })
                
                Section(content: {
                    ForEach(enSUKVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (Scotland, UK)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("English (Scotland, UK)")
                })
                
                Section(content: {
                    ForEach(enSAVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (South Africa)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("English (South Africa)")
                })
                
                Section(content: {
                    ForEach(enUKVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (UK)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("English (UK)")
                })
                
                Section(content: {
                    ForEach(noveltyVoices, id: \.self) { voice in
                        NavigationLink(destination: VoiceDetailView(language: "English (Novelty)", voice: voice), label: {
                            HStack {
                                Text(voice)
                                Spacer()
                                if voice == selectedVoice {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                }
                            }
                        })
                    }
                }, header: {
                    Text("English (Novelty)")
                })
            case "Arabic":
                Section(content: {
                    ForEach(arabicVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Arabic (World)", voice: voice))
                    }
                }, header: {
                    Text("Arabic (World)")
                })
            case "Bangla":
                Section(content: {
                    ForEach(banglaVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Bangla (India)", voice: voice))
                    }
                }, header: {
                    Text("Bangla (India)")
                })
            case "Basque":
                Section(content: {
                    ForEach(basqueVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Basque (Spain)", voice: voice))
                    }
                }, header: {
                    Text("Basque (Spain)")
                })
            case "Bhojpuri":
                Section(content: {
                    ForEach(bhojpuriVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Bhojpuri (India)", voice: voice))
                    }
                }, header: {
                    Text("Bhojpuri (India)")
                })
            case "Bulgarian":
                Section(content: {
                    ForEach(bulgarianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Bulgarian (Bulgaria)", voice: voice))
                    }
                }, header: {
                    Text("Bulgarian (Bulgaria)")
                })
            case "Catalan":
                Section(content: {
                    ForEach(catalanVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Catalan (Spain)", voice: voice))
                    }
                }, header: {
                    Text("Catalan (Spain)")
                })
                
                Section(content: {
                    ForEach(valencianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Valencian (Spain)", voice: voice))
                    }
                }, header: {
                    Text("Valencian (Spain)")
                })
            case "Chinese":
                Section(content: {
                    ForEach(chineseMainlandVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Chinese (China mainland)", voice: voice))
                    }
                }, header: {
                    Text("Chinese (China mainland)")
                })
                
                Section(content: {
                    ForEach(chineseHongKongVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Chinese (Hong Kong)", voice: voice))
                    }
                }, header: {
                    Text("Chinese (Hong Kong)")
                })
                
                Section(content: {
                    ForEach(chineseLiaoningVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Chinese (Liaoning, China mainland)", voice: voice))
                    }
                }, header: {
                    Text("Chinese (Liaoning, China mainland)")
                })
                
                Section(content: {
                    ForEach(chineseShaanxiVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Chinese (Shaanxi, China mainland)", voice: voice))
                    }
                }, header: {
                    Text("Chinese (Shaanxi, China mainland)")
                })
                
                Section(content: {
                    ForEach(chineseSichuanVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Chinese (Shichuan, China mainland)", voice: voice))
                    }
                }, header: {
                    Text("Chinese (Sichuan, China mainland)")
                })
                
                Section(content: {
                    ForEach(chineseTaiwanVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Chinese (Taiwan)", voice: voice))
                    }
                }, header: {
                    Text("Chinese (Taiwan)")
                })
            case "Croatian":
                Section(content: {
                    ForEach(croatianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Croatian (Croatia)", voice: voice))
                    }
                }, header: {
                    Text("Croatian (Croatia)")
                })
            case "Czech":
                Section(content: {
                    ForEach(czechVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Czech (Czechia)", voice: voice))
                    }
                }, header: {
                    Text("Czech (Czechia)")
                })
            case "Danish":
                Section(content: {
                    ForEach(danishVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Danish (Denmark)", voice: voice))
                    }
                }, header: {
                    Text("Danish (Denmark)")
                })
            case "Dutch":
                Section(content: {
                    ForEach(dutchBelgiumVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Dutch (Belgium)", voice: voice))
                    }
                }, header: {
                    Text("Dutch (Belgium)")
                })
                
                Section(content: {
                    ForEach(dutchNetherlands, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Dutch (Netherlands)", voice: voice))
                    }
                }, header: {
                    Text("Dutch (Netherlands)")
                })
            case "Finnish":
                Section(content: {
                    ForEach(finnishVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Finnish (Finland)", voice: voice))
                    }
                }, header: {
                    Text("Finnish (Finland)")
                })
            case "French":
                Section(content: {
                    ForEach(frenchBelgiumVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "French (Belgium)", voice: voice))
                    }
                }, header: {
                    Text("French (Belgium)")
                })
                
                Section(content: {
                    ForEach(frenchCanadaVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "French (Canada)", voice: voice))
                    }
                }, header: {
                    Text("French (Canada)")
                })
                
                Section(content: {
                    ForEach(frenchFranceVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "French (France)", voice: voice))
                    }
                }, header: {
                    Text("French (France)")
                })
            case "Galician":
                Section(content: {
                    ForEach(galicianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Galician (Spain)", voice: voice))
                    }
                }, header: {
                    Text("Galician (Spain)")
                })
            case "German":
                Section(content: {
                    ForEach(germanVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "German (Germany)", voice: voice))
                    }
                }, header: {
                    Text("German (Germany)")
                })
            case "Greek":
                Section(content: {
                    ForEach(greekVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Greek (Greece)", voice: voice))
                    }
                }, header: {
                    Text("Greek (Greece)")
                })
            case "Hebrew":
                Section(content: {
                    ForEach(hebrewVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Hebrew (Israel)", voice: voice))
                    }
                }, header: {
                    Text("Hebrew (Israel)")
                })
            case "Hindi":
                Section(content: {
                    ForEach(hindiVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Hindi (India)", voice: voice))
                    }
                }, header: {
                    Text("Hindi (India)")
                })
            case "Hungarian":
                Section(content: {
                    ForEach(hungarianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Hungarian (Hungary)", voice: voice))
                    }
                }, header: {
                    Text("Hungarian (Hungary)")
                })
            case "Indonesian":
                Section(content: {
                    ForEach(indonesianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Indonesian (Indonesia)", voice: voice))
                    }
                }, header: {
                    Text("Indonesian (Indonesia)")
                })
            case "Italian":
                Section(content: {
                    ForEach(italianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Italian (Italy)", voice: voice))
                    }
                }, header: {
                    Text("Italian (Italy)")
                })
            case "Japanese":
                Section(content: {
                    ForEach(japaneseVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Japanese (Japan)", voice: voice))
                    }
                }, header: {
                    Text("Japanese (Japan)")
                })
            case "Kannada":
                Section(content: {
                    ForEach(kannadaVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Kannada (India)", voice: voice))
                    }
                }, header: {
                    Text("Kannada (India)")
                })
            case "Korean":
                Section(content: {
                    ForEach(koreanVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Korean (Korea)", voice: voice))
                    }
                }, header: {
                    Text("Korean (Korea)")
                })
            case "Malay":
                Section(content: {
                    ForEach(malayVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Malay (Malaysia)", voice: voice))
                    }
                }, header: {
                    Text("Malay (Malaysia)")
                })
            case "Marathi":
                Section(content: {
                    ForEach(marathiVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Marathi (India)", voice: voice))
                    }
                }, header: {
                    Text("Marathi (India)")
                })
            case "Norwegian Bokmål":
                Section(content: {
                    ForEach(norwegianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Norwegian Bokmål (Norway)", voice: voice))
                    }
                }, header: {
                    Text("Norwegian Bokmål (Norway)")
                })
            case "Persian":
                Section(content: {
                    ForEach(persianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Persian (Iran)", voice: voice))
                    }
                }, header: {
                    Text("Persian (Iran)")
                })
            case "Polish":
                Section(content: {
                    ForEach(polishVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Polish (Poland)", voice: voice))
                    }
                }, header: {
                    Text("Polish (Poland)")
                })
            case "Portuguese":
                Section(content: {
                    ForEach(portugueseBrazilVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Portuguese (Brazil)", voice: voice))
                    }
                }, header: {
                    Text("Portuguese (Brazil)")
                })
                
                Section(content: {
                    ForEach(portuguesePortugalVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Portuguese (Portugal)", voice: voice))
                    }
                }, header: {
                    Text("Portuguese (Portugal)")
                })
            case "Romanian":
                Section(content: {
                    ForEach(romanianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Romanian (Romania)", voice: voice))
                    }
                }, header: {
                    Text("Romanian (Romania)")
                })
            case "Russian":
                Section(content: {
                    ForEach(russianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Russian (Russia)", voice: voice))
                    }
                }, header: {
                    Text("Russian (Russia)")
                })
            case "Shanghainese":
                Section(content: {
                    ForEach(shanghaineseVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Shanghainese (China mainland)", voice: voice))
                    }
                }, header: {
                    Text("Shanghainese (China mainland)")
                })
            case "Slovak":
                Section(content: {
                    ForEach(slovakVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Slovak (Slovakia)", voice: voice))
                    }
                }, header: {
                    Text("Slovak (Slovakia)")
                })
            case "Slovenian":
                Section(content: {
                    ForEach(slovenianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Slovenian (Slovenia)", voice: voice))
                    }
                }, header: {
                    Text("Slovenian (Slovenia)")
                })
            case "Spanish":
                Section(content: {
                    ForEach(spanishArgentinaVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Spanish (Argentina)", voice: voice))
                    }
                }, header: {
                    Text("Spanish (Argentina)")
                })
                
                Section(content: {
                    ForEach(spanishChileVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Spanish (Chile)", voice: voice))
                    }
                }, header: {
                    Text("Spanish (Chile)")
                })
                
                Section(content: {
                    ForEach(spanishColumbiaVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Spanish (Colombia)", voice: voice))
                    }
                }, header: {
                    Text("Spanish (Colombia)")
                })
                
                Section(content: {
                    ForEach(spanishMexicoVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Spanish (Mexico)", voice: voice))
                    }
                }, header: {
                    Text("Spanish (Mexico)")
                })
                
                Section(content: {
                    ForEach(spanishSpainVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Spanish (Spain)", voice: voice))
                    }
                }, header: {
                    Text("Spanish (Spain)")
                })
            case "Swedish":
                Section(content: {
                    ForEach(swedishVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Swedish (Swedish)", voice: voice))
                    }
                }, header: {
                    Text("Swedish (Swedish)")
                })
            case "Tamil":
                Section(content: {
                    ForEach(tamilVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Tamil (India)", voice: voice))
                    }
                }, header: {
                    Text("Tamil (India)")
                })
            case "Telugu":
                Section(content: {
                    ForEach(teluguVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Telugu (India)", voice: voice))
                    }
                }, header: {
                    Text("Telugu (India)")
                })
            case "Thai":
                Section(content: {
                    ForEach(thaiVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Thai (Thailand)", voice: voice))
                    }
                }, header: {
                    Text("Thai (Thailand)")
                })
            case "Turkish":
                Section(content: {
                    ForEach(turkishVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Turkish (Türkiye)", voice: voice))
                    }
                }, header: {
                    Text("Turkish (Türkiye)")
                })
            case "Ukrainian":
                Section(content: {
                    ForEach(ukrainianVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Ukrainian (Ukraine)", voice: voice))
                    }
                }, header: {
                    Text("Ukrainian (Ukraine)")
                })
            case "Vietnamese":
                Section(content: {
                    ForEach(vietnameseVoices, id: \.self) { voice in
                        NavigationLink(voice, destination: VoiceDetailView(language: "Vietnamese (Vietnam)", voice: voice))
                    }
                }, header: {
                    Text("Vietnamese (Vietnam)")
                })
            default:
                Text("No voices available.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpeakSelectionVoiceDetailView()
    }
}
