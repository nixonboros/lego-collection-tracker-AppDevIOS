import SwiftUI

struct HomePageView: View {
    @State private var isLoaded = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    // Linear gradient
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(.systemBackground),
                            Color(.systemGray6).opacity(0.4)
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
                                    .fill(Color.orange.opacity(0.08))
                                    .frame(width: 180, height: 180)
                                    .offset(x: -80, y: -40)
                                
                                Circle()
                                    .fill(Color.blue.opacity(0.06))
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
                                    .fill(Color.blue.opacity(0.08))
                                    .frame(width: 220, height: 220)
                                    .offset(x: 80, y: 80)
                                
                                Circle()
                                    .fill(Color.orange.opacity(0.06))
                                    .frame(width: 140, height: 140)
                                    .offset(x: 40, y: 40)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                
                // Main content
                VStack(spacing: 25) {
                    // Header Section
                    VStack(spacing: 20) {
                        ZStack {
                            // Decorative circles on Logo
                            Circle()
                                .fill(Color.orange.opacity(0.1))
                                .frame(width: 130, height: 130)
                                .scaleEffect(isLoaded ? 1 : 0.8)
                                .opacity(isLoaded ? 1 : 0)
                            
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 100, height: 100)
                                .offset(x: 15, y: -10)
                                .scaleEffect(isLoaded ? 1 : 0.8)
                                .opacity(isLoaded ? 1 : 0)
                            
                            // Logo
                            Image(systemName: "cube.box.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.orange, .red],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: .orange.opacity(0.3), radius: 8, x: 0, y: 4)
                                .scaleEffect(isLoaded ? 1 : 0.5)
                                .opacity(isLoaded ? 1 : 0)
                        }
                        .padding(.top, 10)

                        // Title and Description
                        VStack(spacing: 8) {
                            Text("LEGO")
                                .font(.system(size: 36, weight: .light))
                                .foregroundColor(.primary)
                                .offset(y: isLoaded ? 0 : 20)
                                .opacity(isLoaded ? 1 : 0)
                            
                            Text("Collection Tracker")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(.gray)
                                .offset(y: isLoaded ? 0 : 20)
                                .opacity(isLoaded ? 1 : 0)
                            
                            Text("Track your sets and build your collection")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .offset(y: isLoaded ? 0 : 20)
                                .opacity(isLoaded ? 1 : 0)
                        }
                    }
                    
                    // Collection Stats Section
                    VStack(spacing: 20) {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.gray.opacity(0.1),
                                        Color.gray.opacity(0.2),
                                        Color.gray.opacity(0.1)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 1)
                            .padding(.horizontal, 40)
                            .opacity(isLoaded ? 1 : 0)
                        
                        // Collection Stats
                        VStack(spacing: 15) {
                            // Total Sets
                            HStack(spacing: 15) {
                                Image(systemName: "cube.box.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
                                    .frame(width: 40, height: 40)
                                    .background(
                                        Circle()
                                            .fill(Color(red: 0.2, green: 0.5, blue: 0.9).opacity(0.15))
                                    )
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Total Sets")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.gray)
                                    
                                    Text("0")
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                // Built/Unbuilt indicator
                                HStack(spacing: 8) {
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text("Built")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                        Text("0")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.green)
                                    }
                                    
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text("Unbuilt")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gray)
                                        Text("0")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.orange)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3)
                            )
                            .offset(y: isLoaded ? 0 : 30)
                            .opacity(isLoaded ? 1 : 0)
                            
                            // Wishlist
                            HStack(spacing: 15) {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(red: 0.9, green: 0.3, blue: 0.3))
                                    .frame(width: 40, height: 40)
                                    .background(
                                        Circle()
                                            .fill(Color(red: 0.9, green: 0.3, blue: 0.3).opacity(0.15))
                                    )
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Wishlist")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.gray)
                                    
                                    Text("0")
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                                
                                Spacer()
                                
                                // Next purchase indicator
                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("Next Purchase")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.gray)
                                    Text("None")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 3)
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

