//
//  TitleDetailView.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import SwiftUI

struct TitleDetailView: View {
    @Environment(\.dismiss) var dismiss
    let title: Title
    var titleName: String {
        return title.name ?? title.title ?? ""
    }
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack(alignment: .leading) {
                    switch viewModel.videoIdStatus {
                    case .notStarted:
                        EmptyView()
                    case .fetching:
                        ProgressView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                    case .failed(let underlyingError):
                        AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .overlay {
                                    LinearGradient(
                                        stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gradient, location: 1)],
                                        startPoint: .top,
                                        endPoint: .bottom)
                                }
                        } placeholder: {
                            ProgressView()
                        }
                        Text("Could not load trailer. Error: " + underlyingError.localizedDescription)
                            .errorMessage()
                            .padding()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding(5)
                        
                        Text(title.overview ?? "")
                            .padding(5)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            DownloadButton(title: title, displayName: titleName) {
                                dismiss()
                            }
                            
                            Spacer()
                        }
                    }
                    .padding()
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}

