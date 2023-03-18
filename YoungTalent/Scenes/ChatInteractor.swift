//
//  ChatInteractor.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import Foundation

protocol ChatBusinessLogic: AnyObject {
    func fetchData()
}

protocol ChatDataStore: AnyObject {
    var contact: User? { get set }
}

final class ChatInteractor: ChatBusinessLogic, ChatDataStore {
    
    var presenter: ChatPresentationLogic?
    var worker: ChatWorkingLogic = ChatWorker()
    var contact: User?
    
    func fetchData() {
        // fetch contact
        if let contact = contact{
            presenter?.presentContact(.init(user: contact))
        }else{
            presenter?.presentErrorMessage("Failed to load contact info")
        }
    }
}
