import SwiftUI

struct BrowsePageView: View {
    @State private var sets: [LegoSet] = []
    @State private var searchText = ""
    @State private var sortOptions = SortOptions(criteria: .name, isAscending: true)

    enum SortCriteria: String, CaseIterable, Identifiable {
        case name = "Name"
        case setNumber = "Set Number"
        case year = "Year"
        case parts = "Parts"
        var id: String { self.rawValue }
    }

    struct SortOptions {
        var criteria: SortCriteria
        var isAscending: Bool
    }

    // Helper function to get appropriate sort direction label
    private func getSortDirectionLabel() -> String {
        switch sortOptions.criteria {
        case .name, .setNumber:
            return sortOptions.isAscending ? "A-Z" : "Z-A"
        case .year:
            return sortOptions.isAscending ? "Oldest" : "Newest"
        case .parts:
            return sortOptions.isAscending ? "Fewest" : "Most"
        }
    }

    // Helper function to get appropriate sort direction icon
    private func getSortDirectionIcon() -> String {
        switch sortOptions.criteria {
        case .name, .setNumber:
            return sortOptions.isAscending ? "arrow.up" : "arrow.down"
        case .year:
            return sortOptions.isAscending ? "calendar.badge.clock" : "calendar.badge.plus"
        case .parts:
            return sortOptions.isAscending ? "minus.circle" : "plus.circle"
        }
    }

    var filteredAndSortedSets: [LegoSet] {
        let filtered = sets.filter { set in
            guard !searchText.isEmpty else { return true }
            switch sortOptions.criteria {
            case .name:
                return set.name.localizedCaseInsensitiveContains(searchText)
            case .setNumber:
                return set.set_num.localizedCaseInsensitiveContains(searchText)
            case .year:
                return String(set.year).contains(searchText)
            case .parts:
                return String(set.num_parts).contains(searchText)
            }
        }
        
        return filtered.sorted { first, second in
            let comparison: ComparisonResult
            switch sortOptions.criteria {
            case .name:
                comparison = first.name.localizedCaseInsensitiveCompare(second.name)
            case .setNumber:
                comparison = first.set_num.localizedCaseInsensitiveCompare(second.set_num)
            case .year:
                comparison = first.year < second.year ? .orderedAscending : .orderedDescending
            case .parts:
                comparison = first.num_parts < second.num_parts ? .orderedAscending : .orderedDescending
            }
            return sortOptions.isAscending ? comparison == .orderedAscending : comparison == .orderedDescending
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Search and Sort Controls
                    VStack(spacing: 12) {
                        // Search field
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search...", text: $searchText)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(12)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                        
                        // Sort controls
                        HStack(spacing: 8) {
                            // Sort criteria menu
                            Menu {
                                ForEach(SortCriteria.allCases) { criteria in
                                    Button(action: {
                                        sortOptions.criteria = criteria
                                    }) {
                                        HStack {
                                            Text(criteria.rawValue)
                                            if sortOptions.criteria == criteria {
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.up.arrow.down")
                                        .font(.system(size: 14, weight: .semibold))
                                    Text("Sort by \(sortOptions.criteria.rawValue)")
                                        .font(.subheadline)
                                    Spacer()
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                .padding(12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            }
                            
                            // Sort direction button
                            Button(action: { sortOptions.isAscending.toggle() }) {
                                HStack(spacing: 4) {
                                    Image(systemName: getSortDirectionIcon())
                                        .font(.system(size: 14, weight: .semibold))
                                    Text(getSortDirectionLabel())
                                        .font(.subheadline)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.systemGroupedBackground))

                    // Results List
                    if filteredAndSortedSets.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            Text("No sets found")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            if !searchText.isEmpty {
                                Text("Try adjusting your search")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemBackground))
                    } else {
                        List {
                            ForEach(filteredAndSortedSets) { set in
                                NavigationLink(destination: SetDetailPageView(set: set)) {
                                    HStack(spacing: 16) {
                                        // Set Image
                                        AsyncImage(url: URL(string: set.img_url)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Color.gray.opacity(0.2)
                                        }
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                        
                                        // Set Details
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(set.name)
                                                .font(.headline)
                                                .lineLimit(2)
                                            
                                            HStack(spacing: 12) {
                                                Label(set.set_num, systemImage: "number")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                                
                                                Label("\(set.year)", systemImage: "calendar")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationTitle("Browse Sets")
                .onAppear {
                    sets = SetController.loadSets()
                }
            }
        }
    }
}
