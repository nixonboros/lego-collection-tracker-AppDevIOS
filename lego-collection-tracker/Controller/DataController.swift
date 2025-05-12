import Foundation

class DataController {
    // Loads the sets from the CSV file
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

    // Parses the CSV file into a list of LegoSetModel objects
    private static func parseCSV(text: String) -> [LegoSetModel] {
        var lines: [String] = []
        text.enumerateLines { line, _ in lines.append(line) }

        // Initializes the list of LegoSetModel objects
        var legoSets: [LegoSetModel] = []

        // Removes the header line
        _ = lines.removeFirst()

        let csvParser = CSVParser()
        
        // Parses the CSV file
        for line in lines {
            guard let values = csvParser.parse(line: line), values.count == 7 else {
                print("Skipping line (doesn't have 7 columns): \(line)")
                continue
            }

            let set = LegoSetModel(
                set_num: values[0].trimmingCharacters(in: .whitespacesAndNewlines),
                name: values[1].trimmingCharacters(in: .whitespacesAndNewlines),
                year: Int(values[2].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0,
                theme: values[3].trimmingCharacters(in: .whitespacesAndNewlines),
                num_parts: Int(values[4].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0,
                img_url: values[5].trimmingCharacters(in: .whitespacesAndNewlines),
                instructions_url: values[6].trimmingCharacters(in: .whitespacesAndNewlines)
            )
            legoSets.append(set)
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

    // Collection Management Functions
    private static let collectionKey = "userCollection"

    static func addToCollection(_ set: LegoSetModel) {
        var collection = loadCollection()
        if !collection.contains(where: { $0.set_num == set.set_num }) {
            collection.append(set)
            saveCollection(collection)
        }
    }

    static func removeFromCollection(_ set: LegoSetModel) {
        var collection = loadCollection()
        collection.removeAll { $0.set_num == set.set_num }
        saveCollection(collection)
    }

    static func loadCollection() -> [LegoSetModel] {
        if let data = UserDefaults.standard.data(forKey: collectionKey),
           let collection = try? JSONDecoder().decode([LegoSetModel].self, from: data) {
            return collection
        }
        return []
    }

    static func saveCollection(_ sets: [LegoSetModel]) {
        if let encoded = try? JSONEncoder().encode(sets) {
            UserDefaults.standard.set(encoded, forKey: collectionKey)
        }
    }

    static func isInCollection(_ set: LegoSetModel) -> Bool {
        let collection = loadCollection()
        return collection.contains { $0.set_num == set.set_num }
    }
}

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
        
        fields.append(currentField)
        return fields
    }
}
