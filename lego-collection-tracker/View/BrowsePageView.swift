import SwiftUI

struct BrowsePageView: View {
    @State private var sets: [LegoSet] = []
    @State private var searchText = ""

    var filteredSets: [LegoSet] {
        if searchText.isEmpty {
            return sets
        } else {
            return sets.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by Set Name", text: $searchText)
                    .padding()

                List(filteredSets) { set in
                    NavigationLink(destination: SetDetailPageView(set: set)) {
                        Text(set.name)
                    }
                }
            }
            .navigationTitle("Browse Sets")
            .onAppear {
                sets = SetController.loadSets()
            }
        }
    }
}
