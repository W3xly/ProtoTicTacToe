import Combine
import Foundation
import GRPC

enum MySymbol {
    case circle
    case cross

    init?(dto: Symbol) {
        switch dto {
        case .circle:
            self = .circle
        case .cross:
            self = .cross
        case .UNRECOGNIZED:
            return nil
        }
    }
}

final class GameService {
    private let client: SpeedTacToeClientProtocol

    init(client: SpeedTacToeClientProtocol) {
        self.client = client
    }

    func findGame(clientUuid: UUID) async throws -> GameModel {
        var gameSearchHandhake = GameSearchHandshake()
        gameSearchHandhake.clientUuid = clientUuid.uuidString

        let call = client.findGame(gameSearchHandhake, callOptions: CallOptions(timeLimit: .none, cacheable: false))
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            do {
                let response = try call.response.wait()
                let gameModel = GameModel(
                    client: self.client,
                    uuid: UUID(uuidString: response.gameUuid)!,
                    symbol: MySymbol(dto: response.assignedSymbol)!
                )
                continuation.resume(returning: gameModel)
            } catch {
                print("Error: \(error)")
                continuation.resume(throwing: error)
            }
        }
    }
}
