import Foundation
import PromiseKit

class TournamentRequest: TennisAPIRequest {
    private let tour: Tour
    
    init(tour: Tour) {
        self.tour = tour
    }
    
    private lazy var tournamentRequest: URLRequest? = {
        guard let url = URL(string: "\(endpoint)/tournaments/\(tour.rawValue)/2020") else {
            return nil
        }
        var request = URLRequest(url: url)
        request.setValue("715730d190mshc8bf803c8b15f5bp193bd8jsnb644fc474265",
                         forHTTPHeaderField: "x-rapidapi-key")
        return request
    }()
    
    func getTournaments() -> Promise<[Tournament]> {
        let error = NSError(domain: "TournamentRequest",
                            code: 0,
                            userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
        return Promise {[weak self] seal in
            guard let request  = self?.tournamentRequest else {
                seal.reject(error)
                return
            }
            URLSession.shared.dataTask(with: request) {(data, response, _) in
                guard let data = data,
                      let tournaments = try? JSONDecoder().decode(TournamentResponse<Tournament>.self, from: data) else {
                    seal.reject(error)
                    return
                }
                seal.fulfill(tournaments.results)
            }.resume()
        }
    }
}
