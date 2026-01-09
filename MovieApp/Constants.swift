//
//  Constants.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import Foundation
import SwiftUI

struct Constants {
//    TEXT STRINGS
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downloadsString = "Downloads"
    static let downloadButtonString = "Download"
    static let playString = "Play"
    static let trendingMovieString = "Trending Movies"
    static let trendingTVString = "Trending TV"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVString = "Top Rated TV"
    static let movieSearchString = "Movie Search"
    static let tvSearchString = "TV Search"
    static let moviePlaceHolderString = "Search for a Movie"
    static let tvPlaceHolderString = "Search for a TV Show"
    
//    ICONS
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIconString = "arrow.down.to.line"
    static let movieIconString = "movieclapper"
    static let tvIconString = "tv"
    static let downloadButtonIconString = "arrow.down.circle"
    static let playButtonIconString = "play.circle"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles: inout[Title]) {
        for index in titles.indices {
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constants.posterURLStart + path
            }
        }
    }

}

enum YoutubeURLStrings: String {
    case trailer = "trailer"
    case queryShorten = "q"
    case space = " "
    case key  = "key"
}

extension Text {
    func errorMessage() -> some View {
        self
            .foregroundStyle(.red)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

extension Button {
    func ghostButton() -> some View {
        self
            .frame(width: 120, height: 50)
            .foregroundStyle(.buttonText)
            .bold()
            .padding(.horizontal, 10)
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBorder, lineWidth: 5)
                    .fill(.ultraThickMaterial)
            }
    }
}
