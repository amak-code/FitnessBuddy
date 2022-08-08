//
//  GifImage.swift
//  FitnessBuddy
//
//  Created by antikiller on 08.08.2022.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        //let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        guard let url = URL(string: name) else {
            print("Failed in makeUIView() --> invalid url")
            return webView
        }
        do {
            let data = try Data(contentsOf: url)
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "UTF-8",
                baseURL: url.deletingLastPathComponent()
            )
            webView.scrollView.isScrollEnabled = false
            return webView
        } catch {
            print("makeUIView(): Error in the do catch statement")
            return webView
        }
        
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}


struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("pokeball")
    }
}
