import SwiftUI
import WebKit

struct ContentView: View {
    @State private var webView: WKWebView?
    @State private var urlString = "https://hentaivn.autos" // URL mặc định

    var body: some View {
        VStack {
            if let webView = webView {
                WebViewWrapper(webView: webView)
            } else {
                Text("Loading...")
            }
            
            HStack {
                Button(action: {
                    webView?.goBack()
                }) {
                    Image(systemName: "chevron.left")
                }
                .disabled(webView?.canGoBack ?? false)
                Spacer()
                Button(action: {
                    webView?.reload()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                Spacer()
                Button(action: {
                    webView?.goForward()
                }) {
                    Image(systemName: "chevron.right")
                }
                .disabled(webView?.canGoForward ?? false)
            }
            .padding()
        }
        .onAppear {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            let delegate = Coordinator(self)
            webView?.navigationDelegate = delegate
            if let url = URL(string: urlString) {
                webView?.load(URLRequest(url: url))
            } else {
                print("Invalid URL")
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: ContentView
        
        init(_ parent: ContentView) {
            self.parent = parent
        }
        
        // Optional: Implement WKNavigationDelegate methods if needed
    }
}

struct WebViewWrapper: UIViewRepresentable {
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView  {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
