import SwiftUI

struct BrowsePageView: View {
    @State private var sets: [LegoSet] = []
    @State private var searchText = ""
    @State private var searchMode: SearchMode = .name
    @State private var sortMode: SortMode = .name

    enum SearchMode: String, CaseIterable, Identifiable {
        case name = "Name"
        case setNumber = "Set Number"
        var id: String { self.rawValue }
    }

    enum SortMode: String, CaseIterable, Identifiable {
        case name = "Name"
        case year = "Year"
        var id: String { self.rawValue }
    }

    var filteredAndSortedSets: [LegoSet] {
        let filtered: [LegoSet] = {
            guard !searchText.isEmpty else { return sets }
            switch searchMode {
            case .name:
                return sets.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            case .setNumber:
                return sets.filter { $0.set_num.localizedCaseInsensitiveContains(searchText) }
            }
        }()
        
        switch sortMode {
        case .name:
            return filtered.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        case .year:
            return filtered.sorted { $0.year < $1.year }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(.systemGray6), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search...", text: $searchText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    Picker("Search Mode", selection: $searchMode) {
                        ForEach(SearchMode.allCases) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    Picker("Sort By", selection: $sortMode) {
                        ForEach(SortMode.allCases) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)

                    List(filteredAndSortedSets) { set in
                        NavigationLink(destination: SetDetailPageView(set: set)) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(set.name)
                                    .font(.headline)
                                Text("Set #: \(set.set_num)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("Year: \(set.year)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationTitle("Browse Sets")
                .onAppear {
                    sets = SetController.loadSets()
                }
            }
        }
    }
}
