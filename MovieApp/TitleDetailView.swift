//
//  TitleDetailView.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import SwiftUI

struct TitleDetailView: View {
    let title: Title
    var titleName: String {
        return title.name ?? title.title ?? ""
    }
    let viewModel = ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            switch viewModel.videoIdStatus {
            case .notStarted:
                EmptyView()
            case .fetching:
                ProgressView()
                    .frame(width: geo.size.width, height: geo.size.height)
            case .success:
                ScrollView {
                    LazyVStack(alignment: .leading) {
    //                    AsyncImage(url: URL(string: title.posterPath ?? "")) { image in
    //                        image
    //                            .resizable()
    //                            .scaledToFit()
    //                    } placeholder: {
    //                        ProgressView()
    //                    }.frame(width: geo.size.width, height: geo.size.height * 0.85)
                        YoutubePlayer(videoId: viewModel.videoId)
                            .aspectRatio(1.3, contentMode: .fit)
                        
                        Text(titleName)
                            .bold()
                            .font(.title2)
                            .padding(5)
                        
                        Text(title.overview ?? "")
                            .padding(5)
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text(Constants.downloadString)
                                    .ghostButton()
                            }
                            
                            Spacer()
                        }
                        
                        
                    }
                }
            case .failed(let underlyingError):
                Text(underlyingError.localizedDescription)
            }
        }
        .task {
            await viewModel.getVideoId(for: titleName)
        }
    }
}

#Preview {
    TitleDetailView(title: Title.previewTitles[0])
}
