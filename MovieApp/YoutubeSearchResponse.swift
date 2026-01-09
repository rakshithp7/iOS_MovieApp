//
//  YoutubeSearchResponse.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
}
