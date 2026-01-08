//
//  ViewModel.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    
    var trendingMovies: [Title] = []
    var trendingTV: [Title] = []
    var topRatedMovies: [Title] = []
    var topRatedTV: [Title] = []
    var heroTitle = Title.previewTitles[0]
    
    func getTitles() async {
        homeStatus = .fetching
        if trendingMovies.isEmpty {
            do {
                async let tMovies = dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let tTV = dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let trMovies = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let trTV = dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMovies = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await trMovies
                topRatedTV = try await trTV
                
                if let title = trendingMovies.randomElement() {
                    heroTitle = title
                }
                
                homeStatus = .success
            } catch {
                homeStatus = .failed(underlyingError: error)
            }
        } else {
            homeStatus = .success
        }
    }
}
