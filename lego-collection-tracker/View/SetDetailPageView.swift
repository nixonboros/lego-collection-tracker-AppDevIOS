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
                    Color(.systemGray6).opacity(0.4)
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
                    .scaleEffect(isLoaded ? 1 : 0.8)
                    .opacity(isLoaded ? 1 : 0)

                    // Set Details Card
                    VStack(alignment: .leading, spacing: 16) {
                        // Set Number
                        HStack {
                            Image(systemName: "number")
                                .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
                                .frame(width: 24)
                            Text("Set Number")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(set.set_num)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .offset(x: isLoaded ? 0 : -20)
                        .opacity(isLoaded ? 1 : 0)

                        Divider()
                            .background(Color.gray.opacity(0.2))
                            .opacity(isLoaded ? 1 : 0)

                        // Year
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
                                .frame(width: 24)
                            Text("Year")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(set.year)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .offset(x: isLoaded ? 0 : -20)
                        .opacity(isLoaded ? 1 : 0)

                        Divider()
                            .background(Color.gray.opacity(0.2))
                            .opacity(isLoaded ? 1 : 0)

                        // Number of Parts
                        HStack {
                            Image(systemName: "cube.box.fill")
                                .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
                                .frame(width: 24)
                            Text("Number of Parts")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(set.num_parts)")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primary)
                        }
                        .offset(x: isLoaded ? 0 : -20)
                        .opacity(isLoaded ? 1 : 0)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal)
                    .offset(y: isLoaded ? 0 : 20)
                    .opacity(isLoaded ? 1 : 0)

                    // Add to Button
                    Button(action: {
                        showingActionSheet = true
                    }) {
                        HStack {
                            Image(systemName: isInWishlist ? "heart.fill" : "plus.circle.fill")
                                .font(.system(size: 18))
                            Text(isInWishlist ? "Remove from Wishlist" : "Add to...")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    isInWishlist ? Color(red: 0.9, green: 0.3, blue: 0.3) : Color(red: 0.2, green: 0.5, blue: 0.9),
                                    isInWishlist ? Color(red: 0.9, green: 0.3, blue: 0.3).opacity(0.8) : Color(red: 0.2, green: 0.5, blue: 0.9).opacity(0.8)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: (isInWishlist ? Color(red: 0.9, green: 0.3, blue: 0.3) : Color(red: 0.2, green: 0.5, blue: 0.9)).opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal)
                    .offset(y: isLoaded ? 0 : 20)
                    .opacity(isLoaded ? 1 : 0)
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(
                            title: Text("Add to"),
                            buttons: [
                                .default(Text("Add to Collection")) {
                                    // Add to Collection logic
                                    
                                },
                                .default(Text(isInWishlist ? "Remove from Wishlist" : "Add to Wishlist")) {
                                    // Add to Wishlist logic
                                    if isInWishlist {
                                        DataController.removeFromWishlist(set)
                                    } else {
                                        DataController.addToWishlist(set)
                                    }
                                    isInWishlist.toggle()
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
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                isLoaded = true
            }
        }
        .onDisappear {
            isLoaded = false
        }
    }
}
