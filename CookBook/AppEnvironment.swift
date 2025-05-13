//
//  AppEnvironment.swift
//  CookBook
//
//  Created by Kirill Faifer on 01.05.2025.
//

import Foundation

final class AppEnvironment: Sendable {

    static let shared = AppEnvironment()

    let isTestEnvironment: Bool
    let isPreview: Bool
    let isDebugBuild: Bool
    let useInMemoryCoreData: Bool
    let disableAnalytics: Bool

    private init() {
        let arguments = ProcessInfo.processInfo.arguments
        let environment = ProcessInfo.processInfo.environment

        isTestEnvironment = environment["TEST"] == "1"
        isPreview = environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        isDebugBuild = {
            #if DEBUG
            return true
            #else
            return false
            #endif
        }()

        useInMemoryCoreData = isTestEnvironment || isPreview
        disableAnalytics = isTestEnvironment || isDebugBuild
    }
    
}
