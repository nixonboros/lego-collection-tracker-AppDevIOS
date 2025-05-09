import SwiftUI

struct WishlistPageView: View {
    @State private var wishlistSets: [LegoSetModel] = [] // Replace with actual data loading later

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    if wishlistSets.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "tray")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray)
                            
                            Text("Your wishlist is empty.")
                                .font(.title2)
                                .foregroundColor(.secondary)
                            
                            Text("Start adding Lego sets to your wishlist!")
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        Spacer()
                    } else {
                        // add collection lego data logic
                    }
                }
            }
            .navigationTitle("Wishlist")
        }
    }
}
