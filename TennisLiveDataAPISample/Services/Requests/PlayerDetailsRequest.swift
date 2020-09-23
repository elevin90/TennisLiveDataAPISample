import Foundation
import PromiseKit

class PlayerDetailsRequest: TennisAPIRequest {
    
    private let playerId: Int
    
    init(playerId: Int) {
        self.playerId = playerId
    }

    private lazy var detailsRequest: URLRequest? = {
        guard let url = URL(string: "\(endpoint)/player/\(playerId)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.setValue("715730d190mshc8bf803c8b15f5bp193bd8jsnb644fc474265",
                         forHTTPHeaderField: "x-rapidapi-key")
        return request
        
    }()
    
    func getPlayerDetails(withId id: Int) -> Promise<TennisPlayer> {
        let error = NSError(domain: "PlayerDetailsRequest",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        return Promise { seal in
            guard let request = detailsRequest else {
                seal.reject(error)
                return
            }
            URLSession.shared.dataTask(with: request) { (data, response, _) in
                guard let data = data,
                      let response = try? JSONDecoder().decode(PlayerDetailsResponse<TennisPlayer>.self,
                                                               from: data)
                else {
                    seal.reject(error)
                    return
                }
                seal.fulfill(response.results.player)
            }.resume()
        }
    }
}
