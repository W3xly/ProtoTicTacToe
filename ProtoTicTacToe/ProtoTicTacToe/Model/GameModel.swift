import Combine
import Foundation
import GRPC

typealias Point = (row: Int, column: Int)

final class GameModel: CustomDebugStringConvertible {
    var debugDescription: String {
        "GameModel \(uuid), symbol \(symbol)"
    }

    private let uuid: UUID
    private let symbol: MySymbol

    private let client: SpeedTacToeClientProtocol

    private var channel: BidirectionalStreamingCall<Move, GameState>?

    init(
        client: SpeedTacToeClientProtocol,
        uuid: UUID,
        symbol: MySymbol
    ) {
        self.client = client
        self.uuid = uuid
        self.symbol = symbol
    }

    func connectAndObserveState() -> AnyPublisher<GameStateModel, Error> {
        let subject = PassthroughSubject<GameStateModel, Error>()
        channel = client.connect(callOptions: CallOptions(timeLimit: .none, cacheable: false)) { gameState in
            subject.send(GameStateModel())
        }
        return subject.eraseToAnyPublisher()
    }

    func perform(move: Point) async throws {
        guard let channel = channel else {
            throw MoveError.noChannel
        }
        var moveDto = Move()
        moveDto.gameUuid = uuid.uuidString
        moveDto.clientUuid = clientUuid.uuidString
        moveDto.position.row = Int32(move.row)
        moveDto.position.column = Int32(move.column)
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try channel.sendMessage(moveDto).wait()
                continuation.resume(returning: ())
            } catch {
                print("Move error:", error)
                continuation.resume(throwing: error)
            }
        }
    }

    enum MoveError: Error {
        case noChannel
        case notYourTurnMaybe
    }
}

final class GameStateModel {

}
