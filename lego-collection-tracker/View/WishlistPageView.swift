import SwiftUI

struct WishlistPageView: View {
    @State private var wishlistSets: [LegoSetModel] = []
    @State private var searchText = ""
    
    var filteredSets: [LegoSetModel] {
        if searchText.isEmpty {
            return wishlistSets
        }
        return wishlistSets.filter { set in
            set.name.localizedCaseInsensitiveContains(searchText) ||
            set.set_num.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Linear gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color.primaryRed.opacity(0.05),
                        Color.primaryBlue.opacity(0.05)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Search Control
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.primaryBlue)
                            .frame(width: 24)
                        TextField("Search wishlist...", text: $searchText)
                            .font(.system(size: 16, weight: .regular))
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.primaryBlue.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(20)
                    
                    if filteredSets.isEmpty {
                        Spacer()
                        VStack(spacing: 20) {
                            // Decorative circles
                            ZStack {
                                Circle()
                                    .fill(Color.primaryRed.opacity(0.1))
                                    .frame(width: 120, height: 120)
                                
                                Circle()
                                    .fill(Color.primaryRed.opacity(0.1))
                                    .frame(width: 90, height: 90)
                                    .offset(x: 15, y: -10)
                                
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.primaryRed, Color.primaryRed.opacity(0.8)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color.primaryRed.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            VStack(spacing: 8) {
                                if wishlistSets.isEmpty {
                                    Text("Your wishlist is empty")
                                        .font(.system(size: 24, weight: .light))
                                        .foregroundColor(.primary)
                                    
                                    Text("Start adding LEGO sets to your wishlist")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.gray.opacity(0.8))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 40)
                                } else {
                                    Text("No sets found")
                                        .font(.system(size: 24, weight: .light))
                                        .foregroundColor(.primary)
                                    
                                    Text("Try adjusting your search")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.gray.opacity(0.8))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 40)
                                }
                            }
                        }
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredSets) { set in
                                NavigationLink(destination: SetDetailPageView(set: set)) {
                                    HStack(spacing: 16) {
                                        // Set Image
                                        AsyncImage(url: URL(string: set.img_url)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                        }
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(20)
                                        .shadow(color: Color.primaryRed.opacity(0.1), radius: 10, x: 0, y: 5)
                                        
                                        // Set Details
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(set.name)
                                                .font(.system(size: 18, weight: .light))
                                                .lineLimit(2)
                                                .foregroundColor(.primary)
                                            
                                            HStack(spacing: 16) {
                                                Label(set.set_num, systemImage: "number")
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.gray)
                                                
                                                Label("\(set.year)", systemImage: "calendar")
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    .padding(.vertical, 12)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationTitle("Wishlist")
            }
        }
        .onAppear {
            wishlistSets = DataController.loadWishlist()
        }
    }
}
