import SwiftUI

struct HomePageView: View {
    @State private var isLoaded = false
    
    // Saved colours
    private let colourRed = Color(red: 0.91, green: 0.12, blue: 0.12)
    private let colourYellow = Color(red: 1.0, green: 0.85, blue: 0.0)
    private let colourBlue = Color(red: 0.0, green: 0.47, blue: 0.9)
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    // Linear gradient
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(.systemBackground),
                            colourRed.opacity(0.05),
                            colourBlue.opacity(0.05)
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
                                    .fill(colourRed.opacity(0.08))
                                    .frame(width: 180, height: 180)
                                    .offset(x: -80, y: -40)
                                
                                Circle()
                                    .fill(colourBlue.opacity(0.06))
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
                                    .fill(colourBlue.opacity(0.08))
                                    .frame(width: 220, height: 220)
                                    .offset(x: 80, y: 80)
                                
                                Circle()
                                    .fill(colourYellow.opacity(0.06))
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
                        ZStack {
                            // Decorative circles on Logo
                            Circle()
                                .fill(colourRed.opacity(0.1))
                                .frame(width: 110, height: 110)
                                .scaleEffect(isLoaded ? 1 : 0.8)
                                .opacity(isLoaded ? 1 : 0)
                            
                            Circle()
                                .fill(colourBlue.opacity(0.1))
                                .frame(width: 85, height: 85)
                                .offset(x: 12, y: -8)
                                .scaleEffect(isLoaded ? 1 : 0.8)
                                .opacity(isLoaded ? 1 : 0)
                            
                            // Logo
                            Image(systemName: "cube.box.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [colourRed, colourYellow],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: colourRed.opacity(0.3), radius: 8, x: 0, y: 4)
                                .scaleEffect(isLoaded ? 1 : 0.5)
                                .opacity(isLoaded ? 1 : 0)
                        }
                        .padding(.top, 5)

                        // Title and Description
                        VStack(spacing: 6) {
                            Text("LEGO")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [colourRed, colourBlue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
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
                        // Stats Grid
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 15),
                            GridItem(.flexible(), spacing: 15)
                        ], spacing: 15) {
                            // Total Sets Card
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "cube.box.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(colourBlue)
                                        .frame(width: 32, height: 32)
                                        .background(
                                            Circle()
                                                .fill(colourBlue.opacity(0.15))
                                        )
                                    
                                    Spacer()
                                    
                                    Text("0")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                                
                                Text("Total Sets")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                // Built/Unbuilt indicator
                                HStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Built")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                        Text("0")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(colourBlue)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Unbuilt")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                        Text("0")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(colourRed)
                                    }
                                }
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: colourBlue.opacity(0.1), radius: 10, x: 0, y: 3)
                            )
                            .offset(y: isLoaded ? 0 : 30)
                            .opacity(isLoaded ? 1 : 0)
                            
                            // Wishlist Card
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(colourRed)
                                        .frame(width: 32, height: 32)
                                        .background(
                                            Circle()
                                                .fill(colourRed.opacity(0.15))
                                        )
                                    
                                    Spacer()
                                    
                                    Text("0")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                                
                                Text("Wishlist")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                // Next purchase indicator
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Next Purchase")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                    Text("None")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(colourBlue)
                                }
                            }
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: colourRed.opacity(0.1), radius: 10, x: 0, y: 3)
                            )
                            .offset(y: isLoaded ? 0 : 30)
                            .opacity(isLoaded ? 1 : 0)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .onAppear {
                isLoaded = false
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isLoaded = true
                }
            }
            .onDisappear {
                isLoaded = false
            }
        }
    }
}

