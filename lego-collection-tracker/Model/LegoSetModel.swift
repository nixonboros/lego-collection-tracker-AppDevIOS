import Foundation

// LegoSetModel represents Lego set with the following properties:
struct LegoSetModel: Identifiable, Codable {
    let id = UUID()
    let set_num: String
    let name: String
    let year: Int
    let theme_id: Int
    let num_parts: Int
    let img_url: String
    var isFavorite: Bool = false
}
