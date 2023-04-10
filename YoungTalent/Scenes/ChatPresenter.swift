//
//  ChatPresenter.swift
//  YoungTalent
//
//  Created by admin on 16.03.2023.
//

import Foundation

protocol ChatPresentationLogic: AnyObject {
    func presentContact(_ contact: Chat.Case.Response)
    func presentErrorMessage(_ errorMessage: String)
}

final class ChatPresenter: ChatPresentationLogic {
    weak var viewController: ChatDisplayLogic?

    func presentContact(_ contact: Chat.Case.Response) {
        viewController?.displayContact(viewModel: .init(
            nameSurname: contact.user.nameSurname,
            profilePhoto: contact.user.profilePhoto,
            title: contact.user.title
        ))
    }

    func presentErrorMessage(_ errorMessage: String) {
        viewController?.displayErrorMessage(errorMessage)
    }
}
