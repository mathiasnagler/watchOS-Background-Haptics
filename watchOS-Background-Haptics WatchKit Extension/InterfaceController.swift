//
//  InterfaceController.swift
//  watchOS-Background-Haptics WatchKit Extension
//
//  Created by Mathias Nagler on 01.03.17.
//  Copyright © 2017 naglerrr. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

class InterfaceController: WKInterfaceController {

    private let healthStore = HKHealthStore()
    private var workoutSession: HKWorkoutSession?
    fileprivate var hapticFeedbackTimer: Timer?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        startWorkout()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    private func startWorkout() {
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .other
    
        do {
            workoutSession = try HKWorkoutSession(configuration: workoutConfiguration)
            workoutSession?.delegate = self
            healthStore.start(workoutSession!)
        } catch {
            print(error)
        }
    }
    
    @objc fileprivate func vibrate() {
        WKInterfaceDevice.current().play(.success)
    }
}

extension InterfaceController: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didGenerate event: HKWorkoutEvent) {
        
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        switch toState {
        case .running:
            hapticFeedbackTimer = Timer(timeInterval: 5, target: self, selector: #selector(vibrate), userInfo: nil, repeats: true)
            RunLoop.main.add(hapticFeedbackTimer!, forMode: .defaultRunLoopMode)
        default:
            hapticFeedbackTimer?.invalidate()
            hapticFeedbackTimer = nil
        }
    }
}
