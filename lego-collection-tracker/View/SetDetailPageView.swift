import SwiftUI

struct SetDetailPageView: View {
    let set: LegoSetModel
    @State private var showingActionSheet = false
    @State private var isLoaded = false
    @State private var isInWishlist = false
    
    var body: some View {
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
            
            ScrollView {
                VStack(spacing: 25) {
                    // Set Name
                    Text(set.name)
                        .font(.system(size: 24, weight: .light))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                        .offset(y: isLoaded ? 0 : 20)
                        .opacity(isLoaded ? 1 : 0)

                    // Set Image
                    AsyncImage(url: URL(string: set.img_url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 250, height: 250)
                    }
                    .frame(width: 250, height: 250)
                    .scaleEffect(isLoaded ? 1 : 0.5)
                    .opacity(isLoaded ? 1 : 0)

                    // Set Details Card
                    VStack(alignment: .leading, spacing: 16) {
                        // Set Number
                        HStack {
                            Image(systemName: "number")
                                .foregroundColor(Color.primaryBlue)
                                .frame(width: 24)
                            Text("Set Number")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(set.formattedSetNumber)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .offset(y: isLoaded ? 0 : 20)
                        .opacity(isLoaded ? 1 : 0)

                        Divider()
                            .background(Color.gray.opacity(0.2))
                            .opacity(isLoaded ? 1 : 0)

                        // Year
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(Color.primaryBlue)
                                .frame(width: 24)
                            Text("Year")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(set.year)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .offset(y: isLoaded ? 0 : 20)
                        .opacity(isLoaded ? 1 : 0)

                        Divider()
                            .background(Color.gray.opacity(0.2))
                            .opacity(isLoaded ? 1 : 0)

                        // Number of Parts
                        HStack {
                            Image(systemName: "cube.box.fill")
                                .foregroundColor(Color.primaryBlue)
                                .frame(width: 24)
                            Text("Number of Parts")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(set.num_parts)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .offset(y: isLoaded ? 0 : 20)
                        .opacity(isLoaded ? 1 : 0)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.primaryBlue.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                    .offset(y: isLoaded ? 0 : 20)
                    .opacity(isLoaded ? 1 : 0)

                    // View Instructions Button
                    Button(action: {
                        // Add instructions pdf link view
                    }) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                            Text("View Instructions")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemBackground))
                                .shadow(color: Color.primaryBlue.opacity(0.2), radius: 8, x: 0, y: 4)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.primaryBlue, lineWidth: 1.5)
                        )
                        .foregroundColor(Color.primaryBlue)
                    }
                    .padding(.horizontal)
                    .offset(y: isLoaded ? 0 : 20)
                    .opacity(isLoaded ? 1 : 0)

                    // Separator line
                    Divider()
                        .background(Color.black)
                        .padding(.horizontal)
                        .opacity(isLoaded ? 1 : 0)

                    // Collection/Wishlist Buttons
                    VStack(spacing: 12) {
                        if isInWishlist {
                            // Move to Collection button (when in wishlist)
                            Button(action: {
                                // Add to Collection logic
                            }) {
                                HStack {
                                    Image(systemName: "tray.and.arrow.down.fill")
                                    Text("Move to Collection")
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.primaryBlue,
                                            Color.primaryBlue.opacity(0.8)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .shadow(color: Color.primaryBlue.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            // Remove from Wishlist button (when in wishlist)
                            Button(action: {
                                DataController.removeFromWishlist(set)
                                isInWishlist = false
                            }) {
                                HStack {
                                    Image(systemName: "heart.slash.fill")
                                    Text("Remove from Wishlist")
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.primaryRed,
                                            Color.primaryRed.opacity(0.8)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .shadow(color: Color.primaryRed.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                        } else {
                            // Add to Button (when not in wishlist)
                            Button(action: {
                                showingActionSheet = true
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add to...")
                                        .font(.system(size: 16, weight: .medium))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.primaryBlue,
                                            Color.primaryBlue.opacity(0.8)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .shadow(color: Color.primaryBlue.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .offset(y: isLoaded ? 0 : 20)
                    .opacity(isLoaded ? 1 : 0)
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(
                            title: Text("Add to..."),
                            buttons: [
                                .default(Text("Add to Collection")) {
                                    // Add to Collection logic
                                },
                                .default(Text("Add to Wishlist")) {
                                    DataController.addToWishlist(set)
                                    isInWishlist = true
                                },
                                .cancel()
                            ]
                        )
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            isLoaded = false
            isInWishlist = DataController.isInWishlist(set)
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isLoaded = true
            }
        }
        .onDisappear {
            isLoaded = false
        }
    }
}
