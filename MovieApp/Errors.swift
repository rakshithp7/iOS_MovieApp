//
//  Errors.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingErorr: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found"
        case .dataLoadingFailed(underlyingErorr: let error):
            return "Failed to load data from API configuration file: \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Failed to decode API Configuration: \(error.localizedDescription)"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let error):
            return "Bad URL Response: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing API Configuration"
        case .urlBuildFailed:
            return "Failed to build URL"
        }
    }
}
