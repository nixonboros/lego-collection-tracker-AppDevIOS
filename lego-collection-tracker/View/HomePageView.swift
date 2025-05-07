import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image(systemName: "cube.box.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
                    .shadow(radius: 5)
                    .padding(.top)

                Text("Lego Collection")
                    .font(.largeTitle)
                    .fontWeight(.heavy)

                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: .gray.opacity(0.3), radius: 6, x: 0, y: 4)
                    .frame(height: 120)
                    .overlay(
                        VStack {
                            Text("Total Sets Owned")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("0")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.orange)
                        }
                    )
                    .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
        }
    }
}
