//
//  CameraView.swift
//  Preferences
//
//  Settings > Camera
//

import SwiftUI

struct CameraView: View {
    // Variables
    @State private var showingPhotographicStylesView = false
    @State private var useVolumeUpBurstEnabled = false
    @State private var scanQrCodesEnabled = true
    @State private var showDetectedTextEnabled = true
    
    @State private var gridEnabled = false
    @State private var levelEnabled = false
    @State private var mirrorFrontCameraEnabled = false
    @State private var viewOutsideFrameEnabled = true
    
    @State private var sceneDetectionEnabled = true
    @State private var portraitsPhotoModeEnabled = true
    @State private var prioritizeFasterShootingEnabled = true
    @State private var lensCorrectionEnabled = true
    @State private var macroControlEnabled = true
    
    var body: some View {
        CustomList(title: "Camera", topPadding: true) {
            if !UIDevice.isSimulator && UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    CustomNavigationLink(title: "Camera Control", status: "Camera", destination: CameraControlView())
                } header: {
                    Text("System Settings")
                } footer: {
                    Text("Click Camera Control to open a camera app, then click again to use Camera Control as a shutter. Light-press to make adjustments. [Learn more.](#)")
                }
            }
            
            if UIDevice.AdvancedPhotographicStylesCapability {
                Section {
                    Button {
                        showingPhotographicStylesView.toggle()
                    } label: {
                        CustomNavigationLink(title: "Photographic Styles", status: "Standard", destination: EmptyView())
                    }
                    .foregroundStyle(Color["Label"])
                    .fullScreenCover(isPresented: $showingPhotographicStylesView) {
                        NavigationStack {
                            PhotographicStylesView()
                        }
                    }
                } header: {
                    if !UIDevice.isSimulator {
                        Text("App Settings")
                    }
                } footer: {
                    Text("Photographic Styles uses advanced scene understanding to adjust specific colors in different parts of the photo. Personalize how skin tones appear with incredible nuance to get the exact look you want.")
                }
            }
            
            Section {
                CustomNavigationLink(title: "Record Video", status: "1080p at 30 fps", destination: EmptyView())
                CustomNavigationLink(title: "Record Slo-mo", status: "1080p at 240 fps", destination: EmptyView())
                if UIDevice.CinematicModeCapability {
                    CustomNavigationLink(title: "Record Cinematic", status: "1080p at 30 fps", destination: EmptyView())
                }
                if UIDevice.iPhone {
                    CustomNavigationLink(title: "Record Sound", status: UIDevice.AdvancedPhotographicStylesCapability ? "Spatial Audio" : "Stereo", destination: EmptyView())
                }
                NavigationLink("Formats") {}
                NavigationLink("Preserve Settings") {}
                if UIDevice.iPhone {
                    Toggle("Use Volume Up for Burst", isOn: $useVolumeUpBurstEnabled)
                }
                Toggle("Scan QR Codes", isOn: $scanQrCodesEnabled)
                Toggle("Show Detected Text", isOn: $showDetectedTextEnabled)
            }
            
            Section {
                Toggle("Grid", isOn: $gridEnabled)
                Toggle("Level", isOn: $levelEnabled)
                Toggle("Mirror Front Camera", isOn: $mirrorFrontCameraEnabled)
                if UIDevice.PearlIDCapability || UIDevice.iPhone {
                    Toggle("View Outside the Frame", isOn: $viewOutsideFrameEnabled)
                }
            } header: {
                Text("Composition")
            }
            
            if UIDevice.PhotographicStylesCapability {
                Section {
                    Button("Photographic Styles") {}
                } header: {
                    Text("Photo Capture")
                } footer: {
                    Text("Personalize the look of your photos by bringing your preferences into the capture. Photographic Styles use advanced scene understanding to apply the right amount of adjustments to different parts of the photo.")
                }
            } else if UIDevice.iPad {
                Section {
                    Toggle("Scene Detection", isOn: $sceneDetectionEnabled)
                } header: {
                    Text("Photo Capture")
                } footer: {
                    Text("Automatically improve photos of various scenes using intelligent image recognition.")
                }
            }
            
            if UIDevice.ProDevice && UIDevice.iPhone {
                Section {
                    CustomNavigationLink(title: "Main Camera", status: "24 & 28 & 35 mm", destination: EmptyView())
                } header: {
                    if UIDevice.AdvancedPhotographicStylesCapability {
                        Text("Photo Capture")
                    }
                } footer: {
                    Text("Tap the 1× zoom button to toggle between 24 mm and additional lenses.")
                }
            }
            
            if UIDevice.AlwaysCaptureDepthCapability {
                Section {
                    Toggle("Portraits in Photo Mode", isOn: $portraitsPhotoModeEnabled)
                } footer: {
                    Text("Automatically capture depth information if a person, dog, or cat is prominent in the frame in Photo mode, so you can apply Portrait effects later.")
                }
            }
            
            if UIDevice.iPhone {
                Section {
                    Toggle("Prioritize Faster Shooting", isOn: $prioritizeFasterShootingEnabled)
                } footer: {
                    Text("Intelligently adapt image quality when rapidly pressing the shutter.")
                }
            }
            
            if UIDevice.LensCorrectionCapability {
                Section {
                    Toggle("Lens Correction", isOn: $lensCorrectionEnabled)
                } footer: {
                    Text("Correct lens distortion on the front and Ultra Wide camera.")
                }
            }
            
            if UIDevice.MacroLensCapability {
                Section {
                    Toggle("Macro Control", isOn: $macroControlEnabled)
                } footer: {
                    Text("Show Camera control for automatically switching to the Ultra Wide camera to capture macro photos and videos.")
                }
                
                Section {} footer: {
                    Text("[About Camera and ARKit & Privacy...](#)")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CameraView()
    }
}
