import SwiftUI

struct SetDetailPageView: View {
    let set: LegoSet

    @State private var showingActionSheet = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(set.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.top)

                AsyncImage(url: URL(string: set.img_url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .shadow(radius: 5)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 250, height: 250)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Set Number:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(set.set_num)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Year:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(set.year)")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Number of Parts:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(set.num_parts)")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal)

                Button(action: {
                    showingActionSheet = true
                }) {
                    Text("Add to...")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(
                        title: Text("Add to"),
                        buttons: [
                            .default(Text("Collection")) {
                                // Add to collection logic
                            },
                            .default(Text("Wishlist")) {
                                // Add to wishlist logic
                            },
                            .cancel()
                        ]
                    )
                }
            }
            .padding(.bottom)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}
