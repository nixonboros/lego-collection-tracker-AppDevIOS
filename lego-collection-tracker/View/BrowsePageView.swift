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
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search by Set Name", text: $searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                List(filteredSets) { set in
                    NavigationLink(destination: SetDetailPageView(set: set)) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(set.name)
                                .font(.headline)
                            Text("Set #: \(set.set_num)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Browse Sets")
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .onAppear {
                sets = SetController.loadSets()
            }
        }
    }
}
