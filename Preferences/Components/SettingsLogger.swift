//
//  SettingsLogger.swift
//  Preferences
//

import SwiftUI
import os

/// Logging system based on the Logger object that automatically prints in previews and logs in-app.
struct SettingsLogger {
    static let logger = Logger(subsystem: "com.example.Settings", category: "Core")
    
    /// A Boolean value that indicates whether the instance is running in Preview.
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    /// Writes a default-type message to the log.
    /// - Parameters:
    ///   - message: The string that the logger uses to write to the log.
    ///   - level: The scope level to use for the log.
    static func log(_ message: String, level: OSLogType = .default) {
        if isPreview {
            print(message)
        } else {
            logger.log(level: level, "\(message, privacy: .public)")
        }
    }
    
    /// Writes an informative message to the log.
    /// - Parameter message: The string that the logger uses to write to the log.
    static func info(_ message: String) {
        log(message, level: .info)
    }
    
    /// Writes an error message to the log.
    /// - Parameter message: The string that the logger uses to write to the log.
    static func error(_ message: String) {
        log(message, level: .error)
    }
}
