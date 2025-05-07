import Foundation

class SetController {
    static func loadSets() -> [LegoSet] {
        guard let path = Bundle.main.path(forResource: "sets", ofType: "csv") else {
            print("Could not find sets.csv in main bundle")
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

    private static func parseCSV(text: String) -> [LegoSet] {
        var lines: [String] = []
        text.enumerateLines { line, _ in
            lines.append(line)
        }

        var legoSets: [LegoSet] = []
        let header = lines.removeFirst()
        let columns = header.components(separatedBy: ",")

        for line in lines {
            let values = line.components(separatedBy: ",")
            if values.count == columns.count {
                let set_num = values[0]
                let name = values[1]
                // Handle the optional values
                let year = Int(values[2]) ?? 0
                let theme_id = Int(values[3]) ?? 0
                let num_parts = Int(values[4]) ?? 0
                let img_url = values[5]

                let legoSet = LegoSet(set_num: set_num, name: name, year: year, theme_id: theme_id, num_parts: num_parts, img_url: img_url)
                legoSets.append(legoSet)
            }
        }
        return legoSets
    }
}
