import Foundation

struct PlayersRankingResponse<T: Codable>: Codable {
    let results: RankingResults<T>
}

struct RankingResults<T: Codable>: Codable {
    let rankings: [T]
}

struct PlayerDetailsResponse<T: Codable>: Codable {
    let results: PlayerDetailsInfo<T>
}

struct PlayerDetailsInfo<T: Codable>: Codable {
    let player: T
}
