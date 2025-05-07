import SwiftUI

struct SetDetailPageView: View {
    let set: LegoSet

    @State private var showingActionSheet = false

    var body: some View {
        VStack {
            Text("\(set.name)")
                .font(.title)
            Text("Set Number: \(set.set_num)")
            Text("Year: \(set.year)")
            Text("Number of Parts: \(set.num_parts)")
            Button("Add") {
                showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Add to"),
                    buttons: [
                        .default(Text("Collection")) {
                            // add collection logic
                        },
                        .default(Text("Wishlist")) {
                            // add wishlist logic
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
}
