//
//  ChatInteractor.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import Foundation

protocol ChatBusinessLogic: AnyObject {
    func fetchData()
    func fetchLocation()
}

protocol ChatDataStore: AnyObject {
    var contact: User? { get set }
    var location: Chat.Case.Location? { get set }
}

final class ChatInteractor: ChatBusinessLogic, ChatDataStore {
    var presenter: ChatPresentationLogic?
    var worker: ChatWorkingLogic = ChatWorker()
    var contact: User?
    var location: Chat.Case.Location?

    func fetchData() {
        // fetch contact
        if let contact {
            presenter?.presentContact(.init(user: contact))
        } else {
            presenter?.presentErrorMessage("Failed to load contact info")
        }
    }

    func fetchLocation() {
        worker.getCurrentLocation { [weak self] location in
            self?.location = location
        }
    }
}
