import SwiftUI

struct CollectionPageView: View {
    @State private var collectionSets: [LegoSetModel] = [] // Replace with actual data loading later
    @State private var searchText = ""

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
                        TextField("Search collection...", text: $searchText)
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
                    
                    if collectionSets.isEmpty {
                        Spacer()
                        VStack(spacing: 20) {
                            // Decorative circles
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 120, height: 120)
                                
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 90, height: 90)
                                    .offset(x: 15, y: -10)
                                
                                Image(systemName: "tray.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.gray, Color.gray.opacity(0.8)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            VStack(spacing: 8) {
                                Text("Your collection is empty")
                                    .font(.system(size: 24, weight: .light))
                                    .foregroundColor(.primary)
                                
                                Text("Start adding LEGO sets to your collection")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.gray.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                        }
                        Spacer()
                    } else {
                        // Add collection lego data logic
                    }
                }
                .navigationTitle("Collection")
            }
        }
    }
}
