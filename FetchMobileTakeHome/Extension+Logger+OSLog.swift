//
//  Extension+Logger+OSLog.swift
//  FetchMobileTakeHome
//
//  Created by MARIJAN VUKCEVICH on 1/26/25.
//

import Foundation
import OSLog

extension Logger {
    // Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem: String {
            if let bundleIdentifier = Bundle.main.bundleIdentifier {
                return bundleIdentifier
            } else {
                assertionFailure("Bundle identifier is nil. Ensure your project has a valid bundle identifier.")
                return "com.tahner.*"
            }
        }

    private enum LogCategory {
        static let viewCycle = "viewcycle"
        static let statistics = "statistics"
    }
    
    // Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: LogCategory.viewCycle)
    // All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: LogCategory.statistics)
}
