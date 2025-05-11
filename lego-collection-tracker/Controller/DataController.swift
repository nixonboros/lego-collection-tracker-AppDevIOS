import Foundation

class DataController {
    // Loads sets.csv file and returns array of LegoSetModel objects
    static func loadSets() -> [LegoSetModel] {
        guard let path = Bundle.main.path(forResource: "sets", ofType: "csv") else {
            print("Could not find sets.csv")
            return []
        }

        do {
            let csvText = try String(contentsOfFile: path, encoding: .utf8)
            return parseCSV(text: csvText)
        } catch {
            print("Error reading CSV file: \(error)")
            return []
        }
    }

    // Parses sets.csv file and returns array of LegoSetModel objects
    private static func parseCSV(text: String) -> [LegoSetModel] {
        var lines: [String] = []
        text.enumerateLines { line, _ in
            lines.append(line)
        }

        var legoSets: [LegoSetModel] = []
        let header = lines.removeFirst()
        
        // Use CSV parser that handles quoted fields
        let csvParser = CSVParser()
        
        for line in lines {
            guard let values = csvParser.parse(line: line), values.count == 7 else {
                print("Skipping line (doesnt have 7 columns): \(line)")
                continue
            }

            let set_num = values[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let name = values[1].trimmingCharacters(in: .whitespacesAndNewlines)
            let year = Int(values[2].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
            let theme_id = Int(values[3].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
            let num_parts = Int(values[4].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
            let img_url = values[5].trimmingCharacters(in: .whitespacesAndNewlines)
            let instructions_url = values[6].trimmingCharacters(in: .whitespacesAndNewlines)

            let legoSet = LegoSetModel(
                set_num: set_num,
                name: name,
                year: year,
                theme_id: theme_id,
                num_parts: num_parts,
                img_url: img_url,
                instructions_url: instructions_url
            )
            legoSets.append(legoSet)
        }

        return legoSets
    }
    
    // Wishlist Management Functions
    private static let wishlistKey = "userWishlist"
    
    static func addToWishlist(_ set: LegoSetModel) {
        var wishlist = loadWishlist()
        if !wishlist.contains(where: { $0.set_num == set.set_num }) {
            wishlist.append(set)
            saveWishlist(wishlist)
        }
    }
    
    static func removeFromWishlist(_ set: LegoSetModel) {
        var wishlist = loadWishlist()
        wishlist.removeAll { $0.set_num == set.set_num }
        saveWishlist(wishlist)
    }
    
    static func loadWishlist() -> [LegoSetModel] {
        if let data = UserDefaults.standard.data(forKey: wishlistKey),
           let wishlist = try? JSONDecoder().decode([LegoSetModel].self, from: data) {
            return wishlist
        }
        return []
    }
    
    static func saveWishlist(_ sets: [LegoSetModel]) {
        if let encoded = try? JSONEncoder().encode(sets) {
            UserDefaults.standard.set(encoded, forKey: wishlistKey)
        }
    }
    
    static func isInWishlist(_ set: LegoSetModel) -> Bool {
        let wishlist = loadWishlist()
        return wishlist.contains { $0.set_num == set.set_num }
    }
} 

// Add this CSV parser class
class CSVParser {
    func parse(line: String) -> [String]? {
        var fields: [String] = []
        var currentField = ""
        var insideQuotes = false
        
        for char in line {
            if char == "\"" {
                insideQuotes.toggle()
            } else if char == "," && !insideQuotes {
                fields.append(currentField)
                currentField = ""
            } else {
                currentField.append(char)
            }
        }
        
        // Add the last field
        fields.append(currentField)
        
        return fields
    }
}