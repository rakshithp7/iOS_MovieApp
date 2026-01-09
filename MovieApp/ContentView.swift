//
//  ContentView.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constants.homeString, systemImage: Constants.homeIconString){
                HomeView()
            }
            Tab(Constants.upcomingString, systemImage: Constants.upcomingIconString){
                UpcomingView()
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString){
                SearchView()
            }
            Tab(Constants.downloadsString, systemImage: Constants.downloadIconString){
                DownloadView()
            }
        }
    }
}

#Preview {
    ContentView()
}
