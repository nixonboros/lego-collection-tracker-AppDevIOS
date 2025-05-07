import SwiftUI

struct BrowsePageView: View {
    @State private var sets: [LegoSet] = []

    var body: some View {
        NavigationView {
            List(sets) { set in
                NavigationLink(destination: SetDetailPageView(set: set)) {
                    Text(set.name)
                }
            }
            .navigationTitle("Browse Sets")
            .onAppear {
                sets = SetController.loadSets()
            }
        }
    }
}
