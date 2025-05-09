import SwiftUI

struct WishlistPageView: View {
    @State private var wishlistSets: [LegoSetModel] = []
    @State private var searchText = ""
    @State private var sortOptions = SortOptions(criteria: .name, isAscending: true)
    
    var filteredAndSortedSets: [LegoSetModel] {
        SortController.filterAndSort(sets: wishlistSets, searchText: searchText, options: sortOptions)
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
                    VStack(spacing: 16) {
                        // Search field
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
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
                        
                        // Sort controls
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
                                        .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
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
                                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                                )
                            }
                            
                            // Sort direction button
                            Button(action: { sortOptions.isAscending.toggle() }) {
                                HStack(spacing: 8) {
                                    Image(systemName: SortController.getSortDirectionIcon(for: sortOptions))
                                        .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.9))
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
                    
                    if filteredAndSortedSets.isEmpty {
                        Spacer()
                        VStack(spacing: 20) {
                            // Decorative circles
                            ZStack {
                                Circle()
                                    .fill(Color(red: 0.9, green: 0.3, blue: 0.3).opacity(0.1))
                                    .frame(width: 130, height: 130)
                                
                                Circle()
                                    .fill(Color(red: 0.9, green: 0.3, blue: 0.3).opacity(0.1))
                                    .frame(width: 100, height: 100)
                                    .offset(x: 15, y: -10)
                                
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 55, height: 55)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color(red: 0.9, green: 0.3, blue: 0.3), Color(red: 0.9, green: 0.3, blue: 0.3).opacity(0.8)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color(red: 0.9, green: 0.3, blue: 0.3).opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            VStack(spacing: 8) {
                                Text("Your wishlist is empty")
                                    .font(.system(size: 24, weight: .light))
                                    .foregroundColor(.primary)
                                
                                Text("Start adding LEGO sets to your wishlist")
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.gray.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 40)
                            }
                        }
                        Spacer()
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
                                            ProgressView()
                                                .frame(width: 80, height: 80)
                                        }
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(20)
                                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                                        
                                        // Set Details
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(set.name)
                                                .font(.system(size: 18, weight: .light))
                                                .lineLimit(2)
                                                .foregroundColor(.primary)
                                            
                                            HStack(spacing: 16) {
                                                Label(set.set_num, systemImage: "number")
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.gray)
                                                
                                                Label("\(set.year)", systemImage: "calendar")
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                    .padding(.vertical, 12)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationTitle("Wishlist")
            }
        }
        .onAppear {
            wishlistSets = DataController.loadWishlist()
        }
    }
}
