//
//  HapticHelper.swift
//  CookBook
//
//  Created by Kirill Faifer on 15.06.2025.
//

import UIKit.UIImpactFeedbackGenerator

@MainActor
struct HapticHelper {
    
    static func tap(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
    
    static func selectionChanged() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
}
