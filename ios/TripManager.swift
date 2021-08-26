//
//  TripManager.swift
//  ZendriveNative
//
//  Created by Mert Ozyilmaz on 23.10.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

class TMState: NSObject {
    var isUserOnDuty: Bool
    var passengersInCar: Int
    var passengersWaitingForPickup: Int
    var trackingId: String?
    
    init(isUserOnDuty: Bool, passengersInCar: Int, passengersWaitingForPickup: Int, trackingId: String?) {
        self.isUserOnDuty = isUserOnDuty
        self.passengersInCar = passengersInCar
        self.passengersWaitingForPickup = passengersWaitingForPickup
        self.trackingId = trackingId
    }
    
    override func copy() -> Any {
        return TMState.init(
            isUserOnDuty: isUserOnDuty,
            passengersInCar: passengersInCar,
            passengersWaitingForPickup: passengersWaitingForPickup,
            trackingId: trackingId
        )
    }
}

class TripManager: NSObject {
    public static let sharedInstance = TripManager()
    private let _state: TMState
    
    override init() {
        _state = TMState.init(
            isUserOnDuty: false,
            passengersInCar: 0,
            passengersWaitingForPickup: 0,
            trackingId: "trackingId"
        )
        super.init()
    }
    
    public func goOnDuty() {
        ThreadingUtil.synchronized(self, closure: {
            _state.isUserOnDuty = true
            updateTrackingIdIfNeeded()
            ZendriveManager.sharedInstance.updateInsurancePeriodsBasedOnApplicationState()
        })
    }
    
    public func goOffDuty() {
        ThreadingUtil.synchronized(self, closure: {
            _state.isUserOnDuty = false
            updateTrackingIdIfNeeded()
            ZendriveManager.sharedInstance.updateInsurancePeriodsBasedOnApplicationState()
        })
    }
    
    public func acceptNewPassengerRequest() {
        ThreadingUtil.synchronized(self, closure: {
            _state.passengersWaitingForPickup += 1
            updateTrackingIdIfNeeded()
            ZendriveManager.sharedInstance.updateInsurancePeriodsBasedOnApplicationState()
        })
    }
    
    public func cancelPassengerRequest() {
        ThreadingUtil.synchronized(self, closure: {
            _state.passengersWaitingForPickup -= 1
            updateTrackingIdIfNeeded()
            ZendriveManager.sharedInstance.updateInsurancePeriodsBasedOnApplicationState()
        })
    }
    
    public func pickAPassenger() {
        ThreadingUtil.synchronized(self, closure: {
            _state.passengersInCar += 1
            _state.passengersWaitingForPickup -= 1
            updateTrackingIdIfNeeded()
            ZendriveManager.sharedInstance.updateInsurancePeriodsBasedOnApplicationState()
        })
    }
    
    public func dropAPassenger() {
        _state.passengersInCar -= 1
        updateTrackingIdIfNeeded()
        ZendriveManager.sharedInstance.updateInsurancePeriodsBasedOnApplicationState()
    }
    
    public func updateTrackingIdIfNeeded() {
        ThreadingUtil.synchronized(self, closure: {
            if (_state.passengersInCar > 0 || _state.passengersWaitingForPickup > 0) {
                if (_state.trackingId == nil) {
                    _state.trackingId = String.init(format: "%.0f", arguments: [NSDate.init().timeIntervalSince1970*1000])
                }
            } else if (_state.trackingId != nil) {
                _state.trackingId = nil
            }
        })
    }
    
    public func tripManagerState() -> TMState {
        var state: TMState? = nil
        ThreadingUtil.synchronized(self) {
            state = _state.copy() as? TMState
        }
        return state!
    }
}
