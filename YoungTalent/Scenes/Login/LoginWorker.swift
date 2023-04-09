//
//  LoginWorker.swift
//  YoungTalent
//
//  Created by admin on 14.03.2023.
//

import Foundation

protocol LoginWorkingLogic: AnyObject {
    func requestLogin(
        email: String,
        password: String
    ) async throws -> LoginResponse
}

final class LoginWorker: LoginWorkingLogic, HTTPClient {
    func requestLogin(email: String, password: String) async throws -> LoginResponse {
        do {
            let response = try await sendLoginRequest(withEmail: email, password: password)
            return response
        } catch {
            throw error
        }
    }
}
