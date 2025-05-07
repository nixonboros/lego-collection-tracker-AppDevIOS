import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 0.8

    var body: some View {
        TabView {
            HomePageView()
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
