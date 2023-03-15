//
//  OTPWorker.swift
//  YoungTalent
//
//  Created by admin on 15.03.2023.
//

import Foundation

protocol OTPWorkingLogic: AnyObject {
    func verifyOTPCode(_ otpCode: String, completion: @escaping(() -> ()))
}

final class OTPWorker: OTPWorkingLogic {
    
    func verifyOTPCode(_ otpCode: String, completion: @escaping (() -> ())) {
        completion()
    }
}
