import SwiftUI

struct WishlistPageView: View {
    @State private var wishlistSets: [LegoSetModel] = [] // Replace with actual data loading later

    var body: some View {
        NavigationView {
            ZStack {
                // Background with gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGray6).opacity(0.4)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    if wishlistSets.isEmpty {
                        Spacer()
                        VStack(spacing: 20) {
                            // Decorative circles
                            ZStack {
                                Circle()
                                    .fill(Color.orange.opacity(0.1))
                                    .frame(width: 120, height: 120)
                                
                                Circle()
                                    .fill(Color.blue.opacity(0.1))
                                    .frame(width: 90, height: 90)
                                    .offset(x: 15, y: -10)
                                
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.red, .orange],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: .red.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            VStack(spacing: 8) {
                                Text("Your wishlist is empty")
                                    .font(.system(size: 24, weight: .light))
                                    .foregroundColor(.primary)
                                
                                Text("Start adding LEGO sets to your wishlist")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.gray.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                        }
                        Spacer()
                    } else {
                        // add collection lego data logic
                    }
                }
                .navigationTitle("Wishlist")
            }
        }
    }
}
