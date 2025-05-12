import SwiftUI

struct WishlistPageView: View {
    @State private var wishlistSets: [LegoSetModel] = []
    @State private var searchText = ""
    @State private var sortOptions = SortOptions(criteria: .name, isAscending: true)
    @State private var isLoadingSets = true
    
    var filteredSets: [LegoSetModel] {
        let filtered = SortController.filterAndSort(sets: wishlistSets, searchText: searchText, options: sortOptions)
        // Sort to show favorited items first
        return filtered.sorted { $0.isFavorite && !$1.isFavorite }
    } 

    var body: some View {
        NavigationView {
            ZStack {
                // Linear gradient
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
                    
                    if isLoadingSets {
                        // Loading indicator
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.5)
                            Text("Loading wishlist...")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if filteredSets.isEmpty {
                        EmptyStateView(message: "Your wishlist is empty")
                    } else {
                        List {
                            ForEach(filteredSets) { set in
                                NavigationLink(destination: SetDetailPageView(set: set)) {
                                    WishlistSetRowView(set: set, onFavoriteToggle: toggleFavorite)
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
                .navigationTitle("Wishlist")
            }
        }
        .onAppear {
            // First load the sets in the background
            DispatchQueue.global(qos: .userInitiated).async {
                let loadedSets = DataController.loadWishlist()
                
                // Then show them on screen
                DispatchQueue.main.async {
                    wishlistSets = loadedSets
                    isLoadingSets = false
                }
            }
        }
    }
    
    private func toggleFavorite(_ set: LegoSetModel) {
        if let index = wishlistSets.firstIndex(where: { $0.id == set.id }) {
            wishlistSets[index].isFavorite.toggle()
            DataController.saveWishlist(wishlistSets)
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
                TextField("Search wishlist...", text: $searchText)
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

private struct WishlistSetRowView: View {
    let set: LegoSetModel
    let onFavoriteToggle: (LegoSetModel) -> Void

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
            .shadow(color: Color.primaryRed.opacity(0.1), radius: 10, x: 0, y: 5)
            
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
            
            // Favourite Button
            Button(action: {
                onFavoriteToggle(set)
            }) {
                Image(systemName: set.isFavorite ? "star.fill" : "star")
                    .foregroundColor(set.isFavorite ? .yellow : .gray)
                    .font(.system(size: 20))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 12)
    }
}

private struct EmptyStateView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            Text(message)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
