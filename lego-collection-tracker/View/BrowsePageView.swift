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
                        Color.primaryRed.opacity(0.05),
                        Color.primaryBlue.opacity(0.05)
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
                                .foregroundColor(Color.primaryBlue)
                                .frame(width: 24)
                            TextField("Search sets...", text: $searchText)
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

                    // Results List
                    if filteredAndSortedSets.isEmpty {
                        VStack(spacing: 20) {
                            // Decorative circles
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 120, height: 120)
                                
                                Circle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 90, height: 90)
                                    .offset(x: 15, y: -10)
                                
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.gray, Color.gray.opacity(0.8)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                            
                            VStack(spacing: 8) {
                                Text("No sets found")
                                    .font(.system(size: 24, weight: .light))
                                    .foregroundColor(.primary)
                                
                                if !searchText.isEmpty {
                                    Text("Try adjusting your search")
                                        .font(.system(size: 16, weight: .regular))
                                        .foregroundColor(.gray.opacity(0.8))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 40)
                                }
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
                        // Tab bar at bottom for tabview icons
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 49)
                        }
                    }
                }
                .navigationTitle("Browse Sets")
            }
        }
        .onAppear {
            sets = DataController.loadSets()
        }
    }
}
