import Foundation

struct TournamentResponse<T: Codable>: Codable {
    let results: [T]
}
