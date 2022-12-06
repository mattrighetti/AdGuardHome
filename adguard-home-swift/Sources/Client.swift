//
//  File.swift
//  
//
//  Created by Matt on 12/11/2022.
//

import Foundation

public protocol CredentialsProvider {
    var username: String { get set }
    var password: String { get set }
}

public final class AdGuardHomeClient {
    public let ip: String
    private let username: String
    private let password: String

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    public init(ip: String, username: String, password: String) {
        self.ip = ip
        self.username = username
        self.password = password
    }

    // MARK: - Utils

    private func getBaseUrlComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = ip
        components.path = "/control"
        return components
    }

    private func addAuthHeader(_ request: inout URLRequest) {
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginData = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
    }

    private func buildRequest(_ api: API) -> URLRequest {
        var components = getBaseUrlComponents()
        components.path += api.path

        var request = URLRequest(url: components.url!)
        request.httpMethod = api.method
        addAuthHeader(&request)
        return request
    }

    private func requestData(for api: API) async -> Data? {
        let request = buildRequest(api)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
            return data
        } catch {
            return nil
        }
    }

    // MARK: - APIs

    public func getStats() async -> Stats? {
        guard let data = await requestData(for: .stats) else { return nil }
        return try? decoder.decode(Stats.self, from: data)
    }

    public func getStatus() async -> Status? {
        guard let data = await requestData(for: .status) else { return nil }
        return try? decoder.decode(Status.self, from: data)
    }
}
