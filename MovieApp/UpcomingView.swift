//
//  UpcomingView.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import SwiftUI

struct UpcomingView: View {
    let viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader {geo in
                switch viewModel.upcomingStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    VerticalListView(titles: viewModel.upcomingMovies, canDelete: false)
                case .failed(let error):
                    Text(error.localizedDescription)
                        .errorMessage()
                        .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .task {
                await viewModel.getUpcomingMovies()
            }
        }
    }
}

#Preview {
    UpcomingView()
}
