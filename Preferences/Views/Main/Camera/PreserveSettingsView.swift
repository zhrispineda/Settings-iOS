//
//  PreserveSettingsView.swift
//  Preferences
//
//  Settings > Camera > Preserve Settings
//

import SwiftUI

struct PreserveSettingsView: View {
    // Variables
    @AppStorage("CameraPreserveModeSetting") private var cameraMode = false
    @AppStorage("CameraPreserveControlsMenuSetting") private var controlsMenu = false
    @AppStorage("CameraPhotographicStyleSetting") private var photographicStyle = false
    @AppStorage("CameraPreserveCreativeControlsSetting") private var creativeControls = false
    @AppStorage("CameraPreserveApertureSetting") private var depthControl = false
    @AppStorage("CameraPreserveExposureSetting") private var exposureAdjustment = false
    @AppStorage("CameraPreserveNightModeSetting") private var nightMode = false
    @AppStorage("CameraPreservePortraitZoomSetting") private var portraitZoom = false
    @AppStorage("CameraPreserveActionModeSetting") private var actionMode = false
    @AppStorage("CameraPreserveResolutionControlSetting") private var resolutionControl = false
    @AppStorage("CameraPreserveProResSetting") private var proRes = false
    @AppStorage("CameraPreserveLiveSetting") private var livePhoto = true
    let table = "CameraSettings"
    let stylesTable = "CameraSettings-SmartStyles"
    
    var body: some View {
        CustomList(title: "Preserve Settings") {
            if !UIDevice.isSimulator {
                Section {
                    Toggle("CAM_PRESERVE_CAMERA_MODE_SWITCH".localize(table: table), isOn: $cameraMode)
                } footer: {
                    Text("CAM_PRESERVE_CAMERA_MODE_FOOTER".localize(table: table))
                }
                
                if UIDevice.iPhone {
                    Section {
                        Toggle("CAM_PRESERVE_LAST_OPENED_DRAWER_CONTROL_SWITCH".localize(table: table), isOn: $controlsMenu)
                    } footer: {
                        Text("CAM_PRESERVE_LAST_OPENED_DRAWER_CONTROL_FOOTER".localize(table: table))
                    }
                    
                    if UIDevice.AdvancedPhotographicStylesCapability {
                        Section {
                            Toggle("CAM_PRESERVE_SMART_STYLE_SWITCH".localize(table: stylesTable), isOn: $photographicStyle)
                        } footer: {
                            Text("CAM_PRESERVE_LIGHTING_ASPECT_FOOTER".localize(table: stylesTable))
                        }
                    }
                    
                    Section {
                        Toggle("CAM_PRESERVE_PHOTO_FILTER_LIGHTING_APERTURE_SWITCH".localize(table: table), isOn: $creativeControls)
                    } footer: {
                        Text("CAM_PRESERVE_PHOTO_FILTER_LIGHTING_ASPECT_FOOTER".localize(table: table))
                    }
                }
                
                Section {
                    Toggle("CAM_PRESERVE_APERTURE_SWITCH".localize(table: table), isOn: $depthControl)
                } footer: {
                    Text("CAM_PRESERVE_APERTURE_FOOTER".localize(table: table))
                }
                
                if UIDevice.iPhone {
                    if UIDevice.MacroLensCapability {
                        Section {
                            Toggle("AUTO_MACRO_SWITCH".localize(table: table), isOn: $exposureAdjustment)
                        } footer: {
                            Text("CAM_PRESERVE_AUTO_MACRO_FOOTER".localize(table: table))
                        }
                    }
                    
                    Section {
                        Toggle("CAM_PRESERVE_EXPOSURE_SWITCH".localize(table: table), isOn: $exposureAdjustment)
                    } footer: {
                        Text("CAM_PRESERVE_EXPOSURE_FOOTER".localize(table: table))
                    }
                    
                    if UIDevice.NightModeCapability {
                        Section {
                            Toggle("CAM_PRESERVE_NIGHT_MODE_SWITCH".localize(table: table), isOn: $nightMode)
                        } footer: {
                            Text("CAM_PRESERVE_NIGHT_MODE_FOOTER".localize(table: table))
                        }
                    }
                    
                    if UIDevice.AlwaysCaptureDepthCapability {
                        Section {
                            Toggle("CAM_PRESERVE_PORTRAIT_ZOOM_SWITCH".localize(table: table), isOn: $portraitZoom)
                        } footer: {
                            Text("CAM_PRESERVE_PORTRAIT_ZOOM_FOOTER".localize(table: table))
                        }
                    }
                    
                    if UIDevice.ActionModeCapability {
                        Section {
                            Toggle("CAM_PRESERVE_VIDEO_STABILIZATION_SWITCH".localize(table: table), isOn: $actionMode)
                        } footer: {
                            Text("CAM_PRESERVE_VIDEO_STABILIZATION_FOOTER".localize(table: table))
                        }
                    }
                    
                    if UIDevice.RearFacingCameraHDRCapability && UIDevice.AlwaysOnDisplayCapability {
                        Section {
                            Toggle("CAM_PRESERVE_PRO_RAW_48MP_SWITCH".localize(table: table), isOn: $resolutionControl)
                        } footer: {
                            Text("CAM_PRESERVE_PRO_RAW_48MP_FOOTER".localize(table: table))
                        }
                    }
                    
                    if UIDevice.CinematicModeCapability && UIDevice.ProDevice {
                        Section {
                            Toggle("CAM_PRESERVE_PRO_RES_SWITCH".localize(table: table), isOn: $proRes)
                        } footer: {
                            Text("CAM_PRESERVE_PRO_RES_FOOTER".localize(table: table))
                        }
                    }
                }
                
                Section {
                    Toggle("CAM_PRESERVE_LIVE_PHOTO_SWITCH".localize(table: table), isOn: $livePhoto)
                } footer: {
                    Text("CAM_PRESERVE_LIVE_PHOTO_FOOTER".localize(table: table))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PreserveSettingsView()
    }
}
