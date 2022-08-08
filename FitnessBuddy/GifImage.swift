//
//  GifImage.swift
//  FitnessBuddy
//
//  Created by Lily Tran on 8/8/22.
//  followed  Created by Pedro Rojas on 16/08/21

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }
    //static makeUIView( context: Context, completion: @escaping (Result<WKWebView, NetworkError>) -> Void ) {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        //let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        guard let url = URL(string: name) else {
            return webView }
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
            print("Do catch has encountered an error")
            return webView
        }
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}


struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("http://d205bpvrqc9yn1.cloudfront.net/0001.gif")
    }
}
