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
        responseModel: T.Type,
        completion: @escaping (Result<T, RequestError>) -> Void
    )

    func sendLoginRequest(
        withEmail email: String,
        password: String,
        completion: @escaping (Result<LoginResponse, RequestError>) -> Void
    )
}

public extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        completion: @escaping (Result<T, RequestError>) -> Void
    ) {
        let urlComponents = prepareURLComponents(with: endpoint)

        guard let url = urlComponents.url else {
            return completion(.failure(.invalidURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        URLSession.shared.dataTask(with: request) { data, response, _ in

            do {
                guard let response = response as? HTTPURLResponse else {
                    return completion(.failure(.noResponse))
                }

                switch response.statusCode {
                case 200 ... 299:
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data!)
                    return completion(.success(decodedResponse))
                case 401:
                    return completion(.failure(.unauthorized))
                default:
                    return completion(.failure(.unexpectedStatusCode))
                }
            } catch {
                return completion(.failure(.decode))
            }
        }
        .resume()
    }

    func sendLoginRequest(
        withEmail email: String,
        password: String,
        completion: @escaping (Result<LoginResponse, RequestError>) -> Void
    ) {
        let endpoint = AuthEndpoint.login(email, password)
        let urlComponents = prepareURLComponents(with: endpoint)

        guard let url = urlComponents.url else {
            return completion(.failure(.invalidURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        URLSession.shared.dataTask(with: request) { data, response, _ in
            do {
                guard let response = response as? HTTPURLResponse else {
                    return completion(.failure(.noResponse))
                }
                switch response.statusCode {
                case 200 ... 299:
                    let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data!)
                    return completion(.success(decodedResponse))
                case 401:
                    return completion(.failure(.unauthorized))
                default:
                    return completion(.failure(.unexpectedStatusCode))
                }
            } catch {
                return completion(.failure(.decode))
            }
        }
        .resume()
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
