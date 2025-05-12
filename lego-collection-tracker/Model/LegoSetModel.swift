import Foundation

// LegoSetModel represents Lego set with the following properties:
struct LegoSetModel: Identifiable, Codable {
    let id = UUID()
    let set_num: String
    let name: String
    let year: Int
    let theme: String
    let num_parts: Int
    let img_url: String
    let instructions_url: String
    var isFavorite: Bool = false
    var isBuilt: Bool = false
    
    // Get the formatted set number (without dash and numbers after)
    var formattedSetNumber: String {
        if let dashIndex = set_num.firstIndex(of: "-") {
            return String(set_num[..<dashIndex])
        }
        return set_num
    }
}
