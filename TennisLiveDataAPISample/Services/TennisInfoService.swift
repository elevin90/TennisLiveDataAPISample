import Foundation
import PromiseKit

enum Tour: String {
    case ATP
    case WTA
}

protocol TennisInfoServiceProtocol {
    func getRating(forTour tour: Tour)
}

class TennisInfoService: TennisInfoServiceProtocol {
    
    func getRating(forTour tour: Tour) {
        let rankingRequest = PlayersRankingRequest(tour: tour)
        rankingRequest.getRanking()
            .done { players in
                print(players)
            }
            .catch{ error in
                print(error)
        }
    }
    
    func getPlayerDetailsInfo(playerId: Int) {
        let playerDetailsRequest = PlayerDetailsRequest(playerId: playerId)
        playerDetailsRequest.getPlayerDetails(withId: playerId)
            .done { playerInfo in
                print(playerInfo)
            }
            .catch {error in
                print(error)
            }
    }
    
    func getTournamants(tour: Tour) {
        let tournamentRequest = TournamentRequest(tour: tour)
        tournamentRequest.getTournaments()
            .done { tournaments in
                print(tournaments)
            }
            .catch { error in
                print(error)
            }
    }
}
