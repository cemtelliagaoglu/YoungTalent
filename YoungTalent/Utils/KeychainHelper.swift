//
//  KeychainHelper.swift
//  YoungTalent
//
//  Created by admin on 24.03.2023.
//

import Foundation

final class KeychainHelper {
    static let shared = KeychainHelper()

    private init() {}

    func saveData(_ data: Data, service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: service
        ] as CFDictionary

        SecItemAdd(query, nil)
    }

    func loadData(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return result as? Data
    }

    func deleteData(service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        SecItemDelete(query)
    }
}
