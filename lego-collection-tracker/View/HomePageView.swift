import SwiftUI

struct HomePageView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cube.box.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.yellow)

            Text("Lego Collection")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Total Sets Owned: 0")
                .font(.title2)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.white, Color(.systemGray6)]),
                startPoint: .top,
                endPoint: .bottom
                
            )
        )
    }
}
