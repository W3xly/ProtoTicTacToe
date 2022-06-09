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

final class GameViewModel: ObservableObject {

    let columns: [GridItem] = [GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0),
                               GridItem(.flexible(), spacing: 0)]

    @Published var alertItem: AlertItem?
    @Published var gameNotification = GameNotification.waitingForPlayer

    @Published var handShake = GameFoundHandshake()
    @Published var gameState = GameState()

    private let group: EventLoopGroup
    private let client: SpeedTacToeClient
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let connection = ClientConnection.insecure(group: group)
            .connect(host: "127.0.0.1:50051", port: 8080)
        client = SpeedTacToeClient(channel: connection)
    }

    func findGame() {
        let call = client.findGame(Google_Protobuf_Empty())

        Future<GameFoundHandshake, Never> { completion in
            do {
                let response = try call.response.wait()
                completion(.success(response))
            } catch {
                print("Error")
            }
        }
        .map { $0 }
        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
        .receive(on: DispatchQueue.main)
        .assign(to: &$handShake)
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
