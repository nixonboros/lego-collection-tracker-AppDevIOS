import SwiftUI

struct CollectionPageView: View {
    @State private var collectionSets: [LegoSetModel] = [] // Replace with actual data loading later

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
                    if collectionSets.isEmpty {
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
                                
                                Image(systemName: "tray.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.orange, .red],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: .orange.opacity(0.3), radius: 8, x: 0, y: 4)
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
                        // add collection lego data logic
                    }
                }
                .navigationTitle("Collection")
            }
        }
    }
}
