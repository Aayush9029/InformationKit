//
//  APIService.swift
//
//
//  Created by Aayush Pokharel on 2023-05-01.
//

import Foundation

public enum APIServiceError: Error {
    case decodingError(Error)
    case networkError(Error)
    case unknownError(Error)
}

enum APIService {
    static func fetch<T: Decodable>(from url: URL) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)

            return result
        } catch {
            if error is DecodingError {
                throw APIServiceError.decodingError(error)
            } else {
                throw APIServiceError.unknownError(error)
            }
        }
    }

    static func fetchInformations(from url: URL) async throws -> [InformationModel] {
        do {
            let result = try await APIService.fetch(from: url) as [InformationModel]
            return result
        } catch {
            if let apiServiceError = error as? APIServiceError {
                throw apiServiceError
            } else {
                throw APIServiceError.networkError(error)
            }
        }
    }
}
