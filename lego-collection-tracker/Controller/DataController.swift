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
        let columns = header.components(separatedBy: ",")

        for line in lines {
            let values = line.components(separatedBy: ",")
            if values.count == columns.count {
                let set_num = values[0]
                let name = values[1]
                let year = Int(values[2]) ?? 0
                let theme_id = Int(values[3]) ?? 0
                let num_parts = Int(values[4]) ?? 0
                let img_url = values[5]

                let legoSet = LegoSetModel(set_num: set_num, name: name, year: year, theme_id: theme_id, num_parts: num_parts, img_url: img_url)
                legoSets.append(legoSet)
            }
        }
        return legoSets
    }
} 