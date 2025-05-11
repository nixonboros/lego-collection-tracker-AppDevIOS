import Foundation

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

class SortController {
    // Returns appropriate label text for sort direction based on sort criteria and ascending/descending order selected
    static func getSortDirectionLabel(for options: SortOptions) -> String {
        switch options.criteria {
        case .name, .setNumber:
            return options.isAscending ? "A-Z" : "Z-A"
        case .year:
            return options.isAscending ? "Oldest" : "Newest"
        case .parts:
            return options.isAscending ? "Fewest" : "Most"
        }
    }

    // Returns appropriate icon for sort direction based on sort criteria and ascending/descending order selected
    static func getSortDirectionIcon(for options: SortOptions) -> String {
        switch options.criteria {
        case .name, .setNumber:
            return options.isAscending ? "arrow.up" : "arrow.down"
        case .year:
            return options.isAscending ? "calendar.badge.clock" : "calendar.badge.plus"
        case .parts:
            return options.isAscending ? "minus.circle" : "plus.circle"
        }
    }

    // Filters array of Lego sets by search text and sorts by given criteria and direction
    static func filterAndSort(sets: [LegoSetModel], searchText: String, options: SortOptions) -> [LegoSetModel] {
        let filtered = sets.filter { set in
            guard !searchText.isEmpty else { return true }
            return set.name.localizedCaseInsensitiveContains(searchText) || set.set_num.localizedCaseInsensitiveContains(searchText)

        }
        
        return filtered.sorted { first, second in
            let comparison: ComparisonResult
            switch options.criteria {
            case .name:
                comparison = first.name.localizedCaseInsensitiveCompare(second.name)
            case .setNumber:
                comparison = first.set_num.localizedCaseInsensitiveCompare(second.set_num)
            case .year:
                comparison = first.year < second.year ? .orderedAscending : .orderedDescending
            case .parts:
                comparison = first.num_parts < second.num_parts ? .orderedAscending : .orderedDescending
            }
            return options.isAscending ? comparison == .orderedAscending : comparison == .orderedDescending
        }
    }
}
