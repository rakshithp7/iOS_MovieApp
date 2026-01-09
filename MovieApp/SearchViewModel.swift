//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/9/26.
//

import Foundation

@Observable
class SearchViewModel {
    enum FetchStatus {
        case loading
        case success
        case failed(underlyingError: Error)
    }
    
    private(set) var searchStatus: FetchStatus = .loading
    private(set) var searchTitles: [Title] = []
    private let dataFetcher = DataFetcher()
    
    func getSearchTitles(by media: String, for title: String) async {
        do {
            searchStatus = .loading
            if title.isEmpty {
                searchTitles = try await dataFetcher.fetchTitles(for: media, by: "trending")
            } else {
                searchTitles = try await dataFetcher.fetchTitles(for: media, by: "search", with: title)
            }
            searchStatus = .success
        } catch {
            searchTitles = []
            searchStatus = .failed(underlyingError: error)
        }
    }
}

