//
//  DutyController.swift
//  ZendriveNative
//
//  Created by Mert Ozyilmaz on 23.10.2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UIKit

@objc(DutyController)
class DutyController: NSObject, UIApplicationDelegate {
    @objc func initialize(_ driverId: String) {
        ZendriveManager.sharedInstance.initializeSDKForDriverId(
            driverId: driverId,
            successHandler: {
                print("Success handler")
        },
            failureHandler: { (error) in
                let alert: UIAlertController = UIAlertController.init(
                    title: "Initialization Failed",
                    message: error!.localizedFailureReason,
                    preferredStyle: UIAlertController.Style.alert
                )
                
                alert.addAction(UIAlertAction.init(
                    title: "Retry",
                    style: UIAlertAction.Style.default,
                    handler: { (action) in print("Error handler") }
                ))
        }
        )
    }
    
    @objc func setDriverId(_ driverId: NSString) {
        initialize(driverId as String)
    }
    
    @objc func ondutyButtonTapped() {
        TripManager.sharedInstance.goOnDuty()
    }
    
    @objc func goOffDutyButtonTapped() {
        TripManager.sharedInstance.goOffDuty()
    }
    
    @objc func acceptNewRequestButtonTapped() {
        TripManager.sharedInstance.acceptNewPassengerRequest()
    }
    
    @objc func cancelPickupButtonTapped() {
        TripManager.sharedInstance.cancelPassengerRequest()
    }
    
    @objc func pickupPassengerButtonTapped() {
        TripManager.sharedInstance.pickAPassenger()
    }
    
    @objc func dropPassengerButtonTapped() {
        TripManager.sharedInstance.dropAPassenger()
    }
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
