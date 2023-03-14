//
//  WelcomeInteractor.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol WelcomeBusinessLogic: AnyObject {
    func notifyViewDidLoad()
    func switchDarkMode(newValue: Bool)
}

protocol WelcomeDataStore: AnyObject {
    
}

final class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
    
    var presenter: WelcomePresentationLogic?
    var worker: WelcomeWorkingLogic = WelcomeWorker()
    
    func notifyViewDidLoad() {
        worker.fetchData { isDarkMode in
            self.presenter?.presentConfigurations(isDarkMode: isDarkMode)
        }
    }
    func switchDarkMode(newValue: Bool) {
        worker.updateDarkMode(newValue) {
            presenter?.presentDarkMode(newValue)
        }
    }
}
