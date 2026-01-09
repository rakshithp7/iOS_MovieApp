//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import SwiftUI
import SwiftData

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
