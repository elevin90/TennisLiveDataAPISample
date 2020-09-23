import Foundation

class Tournament: Codable {
    let id: Int
    let name: String
    let city: String
    let country: String
    let surface: String
    let code: String
    let startDate: String
    let endDate: String
    let year: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case city
        case country
        case surface
        case code
        case startDate = "start_date"
        case endDate = "end_date"
        case year = "season"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        country = try container.decode(String.self, forKey: .country)
        surface = try container.decode(String.self, forKey: .surface)
        code = try container.decode(String.self, forKey: .code)
        startDate = try container.decode(String.self, forKey: .startDate)
        endDate = try container.decode(String.self, forKey: .endDate)
        year = try container.decode(Int.self, forKey: .year)
    }
}
