//
//  YoutubePlayer.swift
//  MovieApp
//
//  Created by Rakshith Poojary on 1/8/26.
//

import SwiftUI
import WebKit

struct YoutubePlayer: UIViewRepresentable {
    let videoId: String
    
    // MARK: - Create WebView
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        
        return webView
    }
    
    // MARK: - Update WebView
    func updateUIView(_ webView: WKWebView, context: Context) {
        var html: String = ""
        
        html = makeEmbedHTML(
            src: "https://www.youtube-nocookie.com/embed/\(videoId)?playsinline=1&modestbranding=1&rel=0&enablejsapi=1&origin=https://www.youtube-nocookie.com"
        )
        
        print(html)
        
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube-nocookie.com"))
    }
    
    // MARK: - Helper: Build Responsive HTML
    private func makeEmbedHTML(src: String) -> String {
        """
        <html>
        <head>
            <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
        </head>
        <body style="margin:0; padding:0; background:black;">
            <iframe
                width="100%"
                height="100%"
                src="\(src)"
                frameborder="0"
                allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
            </iframe>
        </body>
        </html>
        """
    }
}
