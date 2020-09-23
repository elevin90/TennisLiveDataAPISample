import Foundation
import PromiseKit

class PlayersRankingRequest: TennisAPIRequest {
    
    private let tour: Tour
    
    private lazy var rankingRequest: URLRequest? = {
        guard let url = URL(string: "\(endpoint)/rankings/\(tour.rawValue)") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("715730d190mshc8bf803c8b15f5bp193bd8jsnb644fc474265",
                         forHTTPHeaderField: "x-rapidapi-key")
        return request
        
    }()
    
    init(tour: Tour) {
        self.tour = tour
    }
    
    func getRanking() -> Promise<[TennisPlayer]> {
        let error = NSError(domain: "PlayersRankingRequest",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        return Promise { seal in
            guard let request = rankingRequest else {
                seal.reject(error)
                return
            }
            URLSession.shared.dataTask(with: request) {(data, response, _) in
                guard let data = data, let result = try? JSONDecoder().decode(PlayersRankingResponse<TennisPlayer>.self,
                                                                              from: data) else {
                    seal.reject(error)
                    return
                }
                seal.fulfill(result.results.rankings)
            }.resume()
        }
    }
}

