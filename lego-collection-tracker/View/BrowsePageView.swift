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
                // Linear gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color(.systemGray6).opacity(0.4)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Search and Sort Controls
                    VStack(spacing: 12) {
                        // Search field
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search sets...", text: $searchText)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(12)
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        
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
                                        .font(.system(size: 14, weight: .medium))
                                    Text("Sort by \(sortOptions.criteria.rawValue)")
                                        .font(.system(size: 14, weight: .medium))
                                    Spacer()
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                                .padding(12)
                                .background(Color(.systemBackground))
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                            
                            // Sort direction button
                            Button(action: { sortOptions.isAscending.toggle() }) {
                                HStack(spacing: 4) {
                                    Image(systemName: SortController.getSortDirectionIcon(for: sortOptions))
                                        .font(.system(size: 14, weight: .medium))
                                    Text(SortController.getSortDirectionLabel(for: sortOptions))
                                        .font(.system(size: 14, weight: .medium))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(16)

                    // Results List
                    if filteredAndSortedSets.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundColor(.gray.opacity(0.5))
                            Text("No sets found")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.gray)
                            if !searchText.isEmpty {
                                Text("Try adjusting your search")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.gray.opacity(0.8))
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
                                            Color.gray.opacity(0.1)
                                        }
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(12)
                                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                                        
                                        // Set Details
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(set.name)
                                                .font(.system(size: 16, weight: .medium))
                                                .lineLimit(2)
                                                .foregroundColor(.primary)
                                            
                                            HStack(spacing: 12) {
                                                Label(set.set_num, systemImage: "number")
                                                    .font(.system(size: 13, weight: .regular))
                                                    .foregroundColor(.gray)
                                                
                                                Label("\(set.year)", systemImage: "calendar")
                                                    .font(.system(size: 13, weight: .regular))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    .padding(.vertical, 8)
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
