//
//  TimeLongPressGestureRecognizer.swift
//  CookBook
//
//  Created by Kirill Faifer on 16.06.2025.
//

import UIKit.UIGestureRecognizerSubclass

final class TimeLongPressGestureRecognizer: UIGestureRecognizer {

    var minimumPressDuration: TimeInterval = 0.5
    var targetDuration: TimeInterval = 2.0

    private var initialTouchTime: TimeInterval?
    private var minimumTimer: Timer?
    private var targetTimer: Timer?

    private var hasRecognizedMinimum = false

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard touches.count == 1 else {
            state = .failed
            return
        }

        if let touch = touches.first {
            initialTouchTime = touch.timestamp
        }

        minimumTimer = Timer.scheduledTimer(timeInterval: minimumPressDuration, target: self, selector: #selector(minimumDurationReached), userInfo: nil, repeats: false)
        targetTimer = Timer.scheduledTimer(timeInterval: targetDuration, target: self, selector: #selector(targetDurationReached), userInfo: nil, repeats: false)
    }

    @objc private func minimumDurationReached() {
        if state == .possible {
            state = .began
            hasRecognizedMinimum = true
        }
    }

    @objc private func targetDurationReached() {
        if hasRecognizedMinimum {
            state = .ended
        } else {
            state = .cancelled
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .failed
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if let startTime = initialTouchTime, let touch = touches.first {
            let duration = touch.timestamp - startTime
            if duration < targetDuration {
                state = .cancelled
            } else {
                state = .ended
            }
        } else {
            state = .cancelled
        }

        invalidateTimers()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
        invalidateTimers()
    }

    private func invalidateTimers() {
        minimumTimer?.invalidate()
        targetTimer?.invalidate()
        minimumTimer = nil
        targetTimer = nil
    }

    override func reset() {
        initialTouchTime = nil
        hasRecognizedMinimum = false
        invalidateTimers()
    }
}

