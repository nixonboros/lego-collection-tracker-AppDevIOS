import SwiftUI

struct HomePageView: View {
    @State private var isLoaded = false
    @State private var collectionCount = 0
    @State private var builtCount = 0
    @State private var unbuiltCount = 0
    @State private var wishlistCount = 0
    @State private var favoriteSets: [LegoSetModel] = []
    @State private var currentIndex = 0
    @State private var timer: Timer?
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    // Background gradient
                    LinearGradient(
                            gradient: Gradient(colors: [
                                Color(.systemBackground),
                                Color.primaryRed.opacity(0.05),
                                Color.primaryBlue.opacity(0.05)
                            ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    // Decorative background elements
                    VStack {
                        HStack {
                            // Top left decorative elements
                            ZStack {
                                Circle()
                                    .fill(Color.primaryRed.opacity(0.08))
                                    .frame(width: 180, height: 180)
                                    .offset(x: -80, y: -40)
                                
                                Circle()
                                    .fill(Color.primaryRed.opacity(0.05))
                                    .frame(width: 120, height: 120)
                                    .offset(x: -40, y: -20)
                            }
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            // Bottom right decorative elements
                            ZStack {
                                Circle()
                                    .fill(Color.primaryRed.opacity(0.08))
                                    .frame(width: 220, height: 220)
                                    .offset(x: 80, y: 80)
                                
                                Circle()
                                    .fill(Color.primaryRed.opacity(0.05))
                                    .frame(width: 140, height: 140)
                                    .offset(x: 40, y: 40)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                
                // Main content
                VStack(spacing: 20) {
                    // Header Section
                    VStack(spacing: 15) {
                        // Logo
                        Image("legoBlock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: Color.black.opacity(0.6), radius: 12, x: 0, y: 6)
                            .scaleEffect(isLoaded ? 1 : 0.5)
                            .opacity(isLoaded ? 1 : 0)

                        // Title and Description
                        VStack(spacing: 6) {
                            Text("LEGO")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.black)
                                .offset(y: isLoaded ? 0 : 20)
                                .opacity(isLoaded ? 1 : 0)
                            
                            Text("Collection Tracker")
                                .font(.system(size: 22, weight: .light))
                                .foregroundColor(.gray)
                                .offset(y: isLoaded ? 0 : 20)
                                .opacity(isLoaded ? 1 : 0)
                            
                            Text("Track your sets and build your collection")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.gray.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .offset(y: isLoaded ? 0 : 20)
                                .opacity(isLoaded ? 1 : 0)
                        }
                    }
                    
                    // Collection Stats Section
                    VStack(spacing: 15) {
                        // Stats Cards
                        VStack(spacing: 15) {
                            // Total Sets Card
                            VStack(alignment: .leading, spacing: 8) {
                                // Header
                                HStack(spacing: 12) {
                                    Image(systemName: "cube.box.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.primaryBlue)
                                        .frame(width: 40, height: 40)
                                        .background(
                                            Circle()
                                                .fill(Color.primaryBlue.opacity(0.15))
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Total Sets")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.gray)
                                        Text("\(collectionCount)")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(.primary)
                                    }
                                }
                                
                                Divider()
                                    .background(Color.gray.opacity(0.2))
                                
                                // Stats
                                HStack(spacing: 20) {
                                    // Built
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack(spacing: 6) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.primaryBlue)
                                            Text("Built")
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        Text("\(builtCount)")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.primary)
                                    }
                                    
                                    // Unbuilt
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack(spacing: 6) {
                                            Image(systemName: "circle")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.primaryBlue)
                                            Text("Unbuilt")
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.gray)
                                        }
                                        Text("\(unbuiltCount)")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                            .frame(height: 120)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.primaryBlue.opacity(0.1), radius: 10, x: 0, y: 3)
                            )
                            .offset(y: isLoaded ? 0 : 30)
                            .opacity(isLoaded ? 1 : 0)
                            
                            // Wishlist Card
                            VStack(alignment: .leading, spacing: 8) {
                                // Header
                                HStack(spacing: 12) {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.primaryRed)
                                        .frame(width: 40, height: 40)
                                        .background(
                                            Circle()
                                                .fill(Color.primaryRed.opacity(0.15))
                                        )
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Wishlist")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.gray)
                                        Text("\(wishlistCount)")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(.primary)
                                    }
                                }
                                
                                Divider()
                                    .background(Color.gray.opacity(0.2))
                                
                                // Next purchase scrolling
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.primaryRed)
                                        Text("Next Purchase")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    if favoriteSets.isEmpty {
                                        Text("None")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.gray.opacity(0.8))
                                    } else {
                                        TabView(selection: $currentIndex) {
                                            ForEach(Array(favoriteSets.enumerated()), id: \.element.id) { index, set in
                                                HStack(spacing: 12) {
                                                    // Set Image
                                                    AsyncImage(url: URL(string: set.img_url)) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFill()
                                                    } placeholder: {
                                                        ProgressView()
                                                            .frame(width: 40, height: 40)
                                                    }
                                                    .frame(width: 40, height: 40)
                                                    .cornerRadius(10)
                                                    .shadow(color: Color.primaryRed.opacity(0.1), radius: 5, x: 0, y: 2)
                                                    
                                                    VStack(alignment: .leading, spacing: 4) {
                                                        Text(set.name)
                                                            .font(.system(size: 14, weight: .bold))
                                                            .foregroundColor(.gray.opacity(0.8))
                                                            .lineLimit(1)
                                                        
                                                        Text(set.formattedSetNumber)
                                                            .font(.system(size: 12, weight: .medium))
                                                            .foregroundColor(.gray.opacity(0.6))
                                                    }
                                                    Spacer()
                                                }
                                                .tag(index)
                                            }
                                        }
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        .frame(height: 40)
                                    }
                                }
                            }
                            .frame(height: 120)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.primaryRed.opacity(0.1), radius: 10, x: 0, y: 3)
                            )
                            .offset(y: isLoaded ? 0 : 30)
                            .opacity(isLoaded ? 1 : 0)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                isLoaded = false

                // Load the collection 
                let collection = DataController.loadCollection()
                collectionCount = collection.count
                builtCount = collection.filter { $0.isBuilt }.count
                unbuiltCount = collectionCount - builtCount

                // Load the wishlist
                let wishlist = DataController.loadWishlist()
                wishlistCount = wishlist.count
                favoriteSets = wishlist.filter { $0.isFavorite }
                
                // Start auto-scrolling timer
                startAutoScroll()
                
                // Animation to show the content
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isLoaded = true
                }
            }
            .onDisappear {
                isLoaded = false
                stopAutoScroll()
            }
        }
    }
    
    private func startAutoScroll() {
        // Stop any existing timer
        stopAutoScroll()
        
        // Only start auto-scroll if we have items
        guard !favoriteSets.isEmpty else { return }
        
        // Create a new timer that fires every 3 seconds
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % favoriteSets.count
            }
        }
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}

