//
//  HomeView.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import SwiftUI

struct HomeView: View {
    let viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
        
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
            GeometryReader { geo in
                ScrollView {
                    switch viewModel.homeStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        LazyVStack {
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .overlay {
                                        LinearGradient(
                                            stops: [Gradient.Stop(color: .clear, location: 0.95), Gradient.Stop(color: .gradient, location: 1)],
                                            startPoint: .top,
                                            endPoint: .bottom)
                                    }
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width, height: geo.size.height * 0.95)
                            .overlay(alignment: .bottom) {
                                HStack(spacing: 20) {
                                    Button {
                                        titleDetailPath.append(viewModel.heroTitle)
                                    } label : {
                                        Label {
                                            Text(Constants.playString)
                                        } icon: {
                                            Image(systemName: Constants.playButtonIconString)
                                                .foregroundStyle(.buttonBorder)
                                                .opacity(0.9)
                                        }
                                    }
                                    .ghostButton()

                                    DownloadButton(title: viewModel.heroTitle)
                                }
                                .padding(.bottom, 24) // lift off the very bottom a bit
                            }
                            
                            HorizontalListView(header: Constants.trendingMovieString, titles: viewModel.trendingMovies) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.trendingTVString, titles: viewModel.trendingTV) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedMovieString, titles: viewModel.topRatedMovies) { title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constants.topRatedTVString, titles: viewModel.topRatedTV) { title in
                                titleDetailPath.append(title)
                            }
                        }
                    case .failed(let error):
                        Text(error.localizedDescription)
                            .errorMessage()
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
                .ignoresSafeArea(edges: .top)
                .task {
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
