import SwiftUI

struct CollectionPageView: View {
    @State private var collectionSets: [LegoSetModel] = []
    @State private var searchText = ""
    @State private var sortOptions = SortOptions(criteria: .name, isAscending: true)
    @State private var isLoadingSets = true
    @State private var builtFilter: BuiltFilter = .all
    
    var filteredSets: [LegoSetModel] {
        let filtered = SortController.filterAndSort(sets: collectionSets, searchText: searchText, options: sortOptions)
        switch builtFilter {
        case .all:
            return filtered
        case .built:
            return filtered.filter { $0.isBuilt }
        case .unbuilt:
            return filtered.filter { !$0.isBuilt }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemBackground),
                        Color.primaryRed.opacity(0.05),
                        Color.primaryBlue.opacity(0.05)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Search and Sort Controls
                    SearchAndSortControls(searchText: $searchText, sortOptions: $sortOptions)
                    
                    // Built/Unbuilt Filter Controls
                    HStack(spacing: 12) {
                        FilterButton(
                            title: "All",
                            isSelected: builtFilter == .all,
                            action: { builtFilter = .all }
                        )
                        FilterButton(
                            title: "Built",
                            isSelected: builtFilter == .built,
                            action: { builtFilter = .built }
                        )
                        FilterButton(
                            title: "Unbuilt",
                            isSelected: builtFilter == .unbuilt,
                            action: { builtFilter = .unbuilt }
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                    
                    if isLoadingSets {
                        // Loading indicator
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Loading collection...")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if filteredSets.isEmpty {
                        EmptyStateView(message: "Your collection is empty")
                    } else {
                        List {
                            ForEach(filteredSets) { set in
                                NavigationLink(destination: SetDetailPageView(set: set)) {
                                    CollectionSetRowView(set: set, onBuiltToggle: toggleBuilt)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        // Tab bar at bottom for tabview icons
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 49)
                        }
                    }
                }
                .navigationTitle("Collection")
            }
        }
        .onAppear {
            // First load the sets in the background
            DispatchQueue.global(qos: .userInitiated).async {
                let loadedSets = DataController.loadCollection()
                
                // Then show them on screen
                DispatchQueue.main.async {
                    collectionSets = loadedSets
                    isLoadingSets = false
                }
            }
        }
    }

    // Toggle built/unbuilt status
    private func toggleBuilt(_ set: LegoSetModel) {
        if let index = collectionSets.firstIndex(where: { $0.id == set.id }) {
            collectionSets[index].isBuilt.toggle()
            DataController.saveCollection(collectionSets)
        }
    }
}

private struct SearchAndSortControls: View {
    @Binding var searchText: String
    @Binding var sortOptions: SortOptions

    var body: some View {
        VStack(spacing: 16) {
            // Search Field
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.primaryBlue)
                    .frame(width: 24)
                TextField("Search collection...", text: $searchText)
                    .font(.system(size: 16, weight: .regular))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            )

            // Sort Controls
            HStack(spacing: 12) {
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
                            .foregroundColor(Color.primaryBlue)
                            .frame(width: 24)
                        Text("Sort by \(sortOptions.criteria.rawValue)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.primaryBlue.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                }

                // Sort direction button
                Button(action: { sortOptions.isAscending.toggle() }) {
                    HStack(spacing: 8) {
                        Image(systemName: SortController.getSortDirectionIcon(for: sortOptions))
                            .foregroundColor(Color.primaryBlue)
                            .frame(width: 24)
                        Text(SortController.getSortDirectionLabel(for: sortOptions))
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    )
                }
            }
        }
        .padding(20)
    }
}

private struct CollectionSetRowView: View {
    let set: LegoSetModel
    var onBuiltToggle: ((LegoSetModel) -> Void)? = nil

    var body: some View {
        HStack(spacing: 16) {
            // Set Image
            AsyncImage(url: URL(string: set.img_url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(20)
            .shadow(color: Color.primaryBlue.opacity(0.1), radius: 10, x: 0, y: 5)
            
            // Set Details
            VStack(alignment: .leading, spacing: 8) {
                Text(set.name)
                    .font(.system(size: 18, weight: .light))
                    .lineLimit(2)
                    .foregroundColor(.primary)

                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "number")
                            .font(.system(size: 14, weight: .medium))
                        Text(set.formattedSetNumber)
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.gray)

                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 14, weight: .medium))
                        Text("\(set.year.description)")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.gray)
                }
            }
            Spacer()
            // Built/Unbuilt Toggle Button
            if let onBuiltToggle = onBuiltToggle {
                Button(action: { onBuiltToggle(set) }) {
                    Image(systemName: set.isBuilt ? "checkmark.seal.fill" : "seal")
                        .foregroundColor(set.isBuilt ? .green : .gray)
                        .font(.system(size: 24))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 12)
    }
}

private struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray.2")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            Text(message)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Built/Unbuilt filter enum
private enum BuiltFilter {
    case all, built, unbuilt
}

// Add this new view for the filter buttons
private struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: isSelected ? .medium : .regular))
                .foregroundColor(isSelected ? .white : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color.primaryBlue : Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                )
        }
    }
}
