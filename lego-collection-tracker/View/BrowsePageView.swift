import SwiftUI

struct BrowsePageView: View {
    @State private var sets: [LegoSetModel] = []
    @State private var searchText = ""
    @State private var sortOptions = SortOptions(criteria: .name, isAscending: true)

    var filteredAndSortedSets: [LegoSetModel] {
        SortController.filterAndSort(sets: sets, searchText: searchText, options: sortOptions)
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
                                    Image(systemName: SortController.getSortDirectionIcon(for: sortOptions))
                                        .font(.system(size: 14, weight: .semibold))
                                    Text(SortController.getSortDirectionLabel(for: sortOptions))
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
                    sets = DataController.loadSets()
                }
            }
        }
    }
}
