import SwiftUI

struct CollectionPageView: View {
    @State private var collectionSets: [LegoSetModel] = [] // Replace with actual data loading later

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
                    if collectionSets.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "tray")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.gray)
                            
                            Text("Your collection is empty.")
                                .font(.title2)
                                .foregroundColor(.secondary)
                            
                            Text("Start adding Lego sets to your collection!")
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
                .navigationTitle("Collection")
            }
        }
    }
}
