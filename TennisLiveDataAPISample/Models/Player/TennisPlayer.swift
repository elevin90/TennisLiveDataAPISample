import Foundation

class TennisPlayer: Codable {
    let id: Int
    let name: String
    let secondName: String
    let fullName: String
    let country: String
    let ranking: Int
    let movement: String
    let rankingPoints: Int
    let rankMovement: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "first_name"
        case secondName = "last_name"
        case fullName = "full_name"
        case rankingPoints = "ranking_points"
        case country
        case ranking
        case movement
        case rankMovement = "ranking_movement"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        secondName = try container.decode(String.self, forKey: .secondName)
        fullName = try container.decode(String.self, forKey: .fullName)
        country = try container.decode(String.self, forKey: .country)
        ranking = try container.decode(Int.self, forKey: .ranking)
        if let movement = try? container.decode(String.self, forKey: .movement) {
            self.movement = movement
        } else {
            self.movement = ""
        }
        if let rankMovement = try? container.decode(String.self, forKey: .rankMovement) {
            self.rankMovement = rankMovement
        } else {
            self.rankMovement = ""
        }
        rankingPoints = try container.decode(Int.self, forKey: .rankingPoints)
    }
}
