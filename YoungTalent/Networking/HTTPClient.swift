//
//  HTTPClient.swift
//  YoungTalent
//
//  Created by admin on 10.03.2023.
//

import Foundation

public protocol HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T

    func sendLoginRequest(
        withEmail email: String,
        password: String
    ) async throws -> LoginResponse
}

public extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T {
        let urlComponents = prepareURLComponents(with: endpoint)

        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200 ... 299:
                let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                return decodedResponse
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            throw error
        }
    }

    func sendLoginRequest(
        withEmail email: String,
        password: String
    ) async throws -> LoginResponse {
        let endpoint = AuthEndpoint.login(email, password)
        let urlComponents = prepareURLComponents(with: endpoint)

        guard let url = urlComponents.url else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200 ... 299:
                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                return decodedResponse
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            throw error
        }
    }

    private func prepareURLComponents(
        with endpoint: Endpoint
    ) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = endpoint.port

        if let queryItems = endpoint.queryItems {
            urlComponents.queryItems = queryItems
        }

        return urlComponents
    }
}
