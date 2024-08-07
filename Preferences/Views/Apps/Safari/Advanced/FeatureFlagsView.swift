//
//  FeatureFlagsView.swift
//  Preferences
//
//  Settings > Apps > Safari > Advanced > Feature Flags
//

import SwiftUI

// Structs
struct Flag: Identifiable {
    let id = UUID()
    var title: String
    var isOn = false
}

struct FeatureFlagsView: View {
    // Variables
    @State private var featureFlags = [
        Flag(title: "::grammar-error and ::spelling-error pseudo-elements", isOn: true),
        Flag(title: "::thumb and ::track pseudo-elements", isOn: false),
        Flag(title: "<select> showPicker() method", isOn: false),
        Flag(title: "AbortSignal.any() API", isOn: false),
        Flag(title: "AccessHandle API", isOn: true),
        Flag(title: "Allow WebGL in Web Workers", isOn: true),
        Flag(title: "Allow per media element speaker device selection", isOn: false),
        Flag(title: "Allow speaker device selection", isOn: false),
        Flag(title: "Allow universal access from file: URLs", isOn: false),
        Flag(title: "Alternate WebM Player", isOn: true),
        Flag(title: "Audio description for video - Extended", isOn: false),
        Flag(title: "Audio description for video - Standard", isOn: false),
        Flag(title: "AudioSession API", isOn: true),
        Flag(title: "AudioSession full API", isOn: false),
        Flag(title: "BroadcastChannel API", isOn: true),
        Flag(title: "BroadcastChannel Origin Partitioning", isOn: true),
        Flag(title: "CSS 3D Transform Interoperability for backface-visibility", isOn: false),
        Flag(title: "CSS 3D Transform Interoperability", isOn: true),
        Flag(title: "CSS @counter-style <images> symbols", isOn: false),
        Flag(title: "CSS @counter-style", isOn: true),
        Flag(title: "CSS @font-face size-adjust", isOn: true),
        Flag(title: "CSS Accent Color", isOn: true),
        Flag(title: "CSS Cascade Layers", isOn: true),
        Flag(title: "CSS Contain Intrinsic Size", isOn: true),
        Flag(title: "CSS Container Queries", isOn: true),
        Flag(title: "CSS Containment", isOn: true),
        Flag(title: "CSS Content Visibility", isOn: false),
        Flag(title: "CSS Custom Properties and Values API", isOn: true),
        Flag(title: "CSS Gradient Interpolation Color Spaces", isOn: true),
        Flag(title: "CSS Gradient Premultiplied Alpha Interpolation", isOn: true),
        Flag(title: "CSS Input Security", isOn: false),
        Flag(title: "CSS Masonry Layout", isOn: false),
        Flag(title: "CSS Motion Path", isOn: true),
        Flag(title: "CSS Nesting", isOn: true),
        Flag(title: "CSS Overscroll Behavior", isOn: true),
        Flag(title: "CSS Painting API", isOn: false),
        Flag(title: "CSS Relative Color Syntax", isOn: true),
        Flag(title: "CSS Rhythmic Sizing", isOn: false),
        Flag(title: "CSS Scroping (@scope)", isOn: true),
        Flag(title: "CSS Scroll Anchoring", isOn: false),
        Flag(title: "CSS Typed OM", isOn: true),
        Flag(title: "CSS Typed OM: Color Support", isOn: false),
        Flag(title: "CSS Unprefixed Backdrop Filter", isOn: false),
        Flag(title: "CSS based Ruby implementation in IFC", isOn: true),
        Flag(title: "CSS color-contrast()", isOn: false),
        Flag(title: "CSS color-mix()", isOn: true),
        Flag(title: "CSS font-variant-emoji property", isOn: false),
        Flag(title: "CSS margin-trim property", isOn: true),
        Flag(title: "CSS scrollbar-color property", isOn: false),
        Flag(title: "CSS scrollbar-gutter property", isOn: false),
        Flag(title: "CSS scrollbar-width-property", isOn: false),
        Flag(title: "CSS subgrid support", isOn: true),
        Flag(title: "CSS text-box-trim property", isOn: false),
        Flag(title: "CSS text-group-align property", isOn: false),
        Flag(title: "CSS text-justify property", isOn: false),
        Flag(title: "CSS text-spacing property", isOn: false),
        Flag(title: "CSS text-wrap-style property", isOn: false),
        Flag(title: "CSS text-wrap property: pretty", isOn: false),
        Flag(title: "CSSOM View Scrolling API", isOn: true),
        Flag(title: "CSSOM View Smooth Scrolling", isOn: true),
        Flag(title: "Canvas Color Spaces", isOn: true),
        Flag(title: "Clear-Site-Data HTTP Header", isOn: true),
        Flag(title: "Compression Stream API", isOn: true),
        Flag(title: "Constructable Stylesheets", isOn: true),
        Flag(title: "Contact Picker API", isOn: false),
        Flag(title: "Cookie Store API Extended Attributes", isOn: false),
        Flag(title: "Cookie Store API for Service Workers", isOn: false),
        Flag(title: "Cross-Origin-Embedder-Policy (COEP) header", isOn: true),
        Flag(title: "Cross-Origin-Opener-Policy (COOP) header", isOn: true),
        Flag(title: "Declarative Shadow Roots Parser APIs", isOn: false),
        Flag(title: "Declarative Shadow Roots", isOn: true),
        Flag(title: "Default ARIA for Custom Elements", isOn: true),
        Flag(title: "Defer async scripts until DOMContentLoaded or first-paint", isOn: true),
        Flag(title: "Deprecate RSAES-PKCS1-v1_5 Web Crypto", isOn: true),
        Flag(title: "Deprecation Reporting", isOn: false),
        Flag(title: "Detect UA visual transitions", isOn: false),
        Flag(title: "Disable Full 3rd-Party Cookie Blocking (ITP)", isOn: false),
        Flag(title: "Disable Removal of Non-Cookie Data After 7 Days of No User Interaction (ITP)", isOn: false),
        Flag(title: "Disallow sync XHR during page dismissal", isOn: true),
        Flag(title: "Enable Canvas fingerprinting-related quirk", isOn: true),
        Flag(title: "Enable background-fetch API", isOn: false),
        Flag(title: "Enable experimental network loader", isOn: false),
        Flag(title: "FTP support enabled", isOn: false),
        Flag(title: "Fetch Metadata", isOn: true),
        Flag(title: "Fetch Priority", isOn: true),
        Flag(title: "File System Access API", isOn: true),
        Flag(title: "Filter Link Decoration", isOn: false),
        Flag(title: "Form requestSubmit", isOn: true),
        Flag(title: "Form-associated custom elements", isOn: true),
        Flag(title: "GPU Process: Canvas Rendering", isOn: true),
        Flag(title: "GPU Process: DOM Rendering", isOn: true),
        Flag(title: "Gamepad trigger vibration support", isOn: false),
        Flag(title: "Gamepad.vibrationActuator support", isOn: false),
        Flag(title: "GraphicsContext Filter Rendering", isOn: true),
        Flag(title: "HTML <dialog> element", isOn: true),
        Flag(title: "HTML <model> element", isOn: false),
        Flag(title: "HTML <model> elements for stand-alone document", isOn: false),
        Flag(title: "HTML invoketarget & invokeaction attributes", isOn: true),
        Flag(title: "HTML popover attribute", isOn: true),
        Flag(title: "HTML switch control", isOn: true),
        Flag(title: "Highlight API", isOn: true),
        Flag(title: "ITP Debug Mode", isOn: false),
        Flag(title: "Image Animation Control", isOn: true),
        Flag(title: "Image Capture API", isOn: false),
        Flag(title: "Imperative Slot API", isOn: true),
        Flag(title: "IsLoggedIn web API", isOn: false),
        Flag(title: "Lazy iframe loading", isOn: true),
        Flag(title: "Lazy image loading", isOn: true),
        Flag(title: "Legacy showModalDialog() API", isOn: false),
        Flag(title: "Link preload responsive images", isOn: true),
        Flag(title: "Link rel=modulepreload", isOn: true),
        Flag(title: "Link rel=preconnect via HTTP early hints", isOn: true),
        Flag(title: "LinkPrefetch", isOn: false),
        Flag(title: "Live Ranges in Selection", isOn: true),
        Flag(title: "Managed Media Source API", isOn: true),
        Flag(title: "Managed Media Source Requires AirPlay Source", isOn: true),
        Flag(title: "Mask WebGL Strings", isOn: true),
        Flag(title: "Media Capabilities Extensions", isOn: true),
        Flag(title: "MediaRecorder", isOn: true),
        Flag(title: "Navigation API", isOn: false),
        Flag(title: "Next-generation inline layout (IFC)", isOn: true),
        Flag(title: "Notifications", isOn: false),
        Flag(title: "OffscreenCanvas in Workers", isOn: true),
        Flag(title: "OffscreenCanvas", isOn: true),
        Flag(title: "Partition Blob URL Registry", isOn: true),
        Flag(title: "PermissionsAPI", isOn: true),
        Flag(title: "Prefer Page Rendering Updates near 60fps", isOn: true),
        Flag(title: "Private Click Measurement Debug Mode", isOn: false),
        Flag(title: "Private Click Measurement Fraud Prevention", isOn: true),
        Flag(title: "ReadableByteStream", isOn: false),
        Flag(title: "Reporting API", isOn: true),
        Flag(title: "RequestVideoFrameCallback", isOn: true),
        Flag(title: "Screen Orientation API (Locking / Unlocking)", isOn: false),
        Flag(title: "Screen Orientation API", isOn: true),
        Flag(title: "Screen Wake Lock API", isOn: true),
        Flag(title: "ScreenCapture", isOn: false),
        Flag(title: "Scroll To Text Fragment", isOn: true),
        Flag(title: "Scroll-driven Animations", isOn: false),
        Flag(title: "Selection API for shadow DOM", isOn: true),
        Flag(title: "Send mouse events to disabled form controls", isOn: true),
        Flag(title: "Service Worker Navigation Preload", isOn: true),
        Flag(title: "Service Workers", isOn: true),
        Flag(title: "Shape Detection API", isOn: false),
        Flag(title: "SharedWorker", isOn: true),
        Flag(title: "Show Media Stats", isOn: false),
        Flag(title: "Sideways writing modes", isOn: false),
        Flag(title: "Storage API Estimate", isOn: true),
        Flag(title: "Storage API", isOn: true),
        Flag(title: "Swap Process on Cross-Site Navigation", isOn: true),
        Flag(title: "Track Configuration API", isOn: false),
        Flag(title: "Unprefixed Fullscreen API", isOn: true),
        Flag(title: "User Activation API", isOn: true),
        Flag(title: "Verify window.open user gesture", isOn: false),
        Flag(title: "Vertical form control support", isOn: true),
        Flag(title: "View Transitions", isOn: false),
        Flag(title: "Web Animations custom effects", isOn: false),
        Flag(title: "Web Animations custom frame rate", isOn: false),
        Flag(title: "Web Crypto Safe Curves", isOn: true),
        Flag(title: "Web Crypto X25519 algorithm", isOn: false),
        Flag(title: "Web Locks API", isOn: true),
        Flag(title: "Web Share API Level 2", isOn: true),
        Flag(title: "WebAssembly ES module integration support", isOn: false),
        Flag(title: "WebCodecs AV1 codec", isOn: false),
        Flag(title: "WebCodecs Audio API", isOn: false),
        Flag(title: "WebCodecs HEVC codec", isOn: true),
        Flag(title: "WebCodecs Video API", isOn: true),
        Flag(title: "WebGL Draft Extensions", isOn: false),
        Flag(title: "WebGL Timer Queries", isOn: false),
        Flag(title: "WebGPU", isOn: false),
        Flag(title: "WebRTC AV1 codec", isOn: false),
        Flag(title: "WebRTC Encoded Transform API", isOn: true),
        Flag(title: "WebRTC H265 codec", isOn: false),
        Flag(title: "WebRTC SFrame Transform API", isOn: false),
        Flag(title: "WebRTC VP9 profile 2 codec", isOn: true),
        Flag(title: "WebTransport", isOn: false),
        Flag(title: "[ITP Live-On] 1 Hour Timeout For Non-Cookie Data Removal", isOn: false),
        Flag(title: "[ITP Repro] 30 Second Timeout For Non-Cookie Data Removal", isOn: false),
        Flag(title: "align-content on blocks", isOn: true),
        Flag(title: "element.checkVisibility() API", isOn: true),
        Flag(title: "requestIdleCallback", isOn: false),
        Flag(title: "word-break: auto-phrase enabled", isOn: false),
        Flag(title: "Passkeys site-specific hacks", isOn: true),
        Flag(title: "Fullscreen API", isOn: false)
    ]
    
    var body: some View {
        CustomList(title: "WebKit Feature Flags") {
            Section {
                ForEach($featureFlags) { $flag in
                    HStack { // Temporary workaround since 2-lined text can push toggles
                        Text(flag.title)
                        Spacer()
                        Toggle(flag.title, isOn: $flag.isOn)
                            .labelsHidden()
                    }
                }
            } header: {
                Text("WebKit Feature Flags")
            }
            
            Section {
                Button("Reset All to Defaults") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeatureFlagsView()
    }
}
