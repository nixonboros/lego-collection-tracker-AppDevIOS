import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Landing Page")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            BrowsePageView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
            CollectionPageView()
                .tabItem {
                    Label("Collection", systemImage: "tray.2")
                }
            WishlistPageView()
                .tabItem {
                    Label("Wishlist", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}
