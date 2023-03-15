//
//  OTPInteractor.swift
//  YoungTalent
//
//  Created by admin on 15.03.2023.
//

import Foundation

protocol OTPBusinessLogic: AnyObject {
    func verifyOTP(_ otpCode: String)
}

protocol OTPDataStore: AnyObject {
    
}

final class OTPInteractor: OTPBusinessLogic, OTPDataStore {
    
    var presenter: OTPPresentationLogic?
    var worker: OTPWorkingLogic = OTPWorker()
    
    func verifyOTP(_ otpCode: String) {
        worker.verifyOTPCode(otpCode) {
            self.presenter?.presentSuccess()
        }
    }
}
