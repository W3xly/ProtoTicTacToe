//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 26.09.2021.
//

import SwiftUI
import Combine
import GRPC
import SwiftProtobuf
import NIO

let clientUuid = UUID()

final class GameViewModel: ObservableObject {

    let columns: [GridItem] = [GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0)]

    @Published var alertItem: AlertItem?
    @Published var gameNotification = GameNotification.waitingForPlayer

    private let gameService: GameService

    private let group: EventLoopGroup
    private let client: SpeedTacToeClient
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let connection = ClientConnection.insecure(group: group)
            .withCallStartBehavior(.fastFailure)
            .withKeepalive(.init(timeout: .hours(1)))
            .connect(host: "2.tcp.eu.ngrok.io", port: 12377)
        client = SpeedTacToeClient(channel: connection)

        gameService = GameService(client: client)
    }

    func findGame() {
        Task {
            print("finding game as client \(clientUuid.uuidString)")
            let gameModel = try await gameService.findGame(clientUuid: clientUuid)
            print(gameModel.debugDescription)
        }
    }

    func connect() {
        let call = client.connect(callOptions: .none) { gameState in
            print(gameState)
        }

//        Future<(Move, GameState), Never> { completion in
//            do {
//                let response = try call.response.wait()
//                completion(.success(response))
//            } catch {
//                print("Error")
//            }
//        }
    }
    
    func getIndicator(for index: Int) -> String {
        index % 2 == 0 ? "multiply" : "circle"
    }
    
    func processPlayerMove(for index: Int) {

    }

    func quitGame() {
        
    }
    
    func updateGameNotificationFor(_ state: GameStateInfo) {
        switch state {
        case .started:
            gameNotification = GameNotification.gameHasStarted
        case .waitingForPlayer:
            gameNotification = GameNotification.waitingForPlayer
        case .finished:
            gameNotification = GameNotification.gameFinished
        }
    }
}
