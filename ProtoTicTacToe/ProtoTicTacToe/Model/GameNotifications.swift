//
//  GameNotifications.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 28.09.2021.
//

import SwiftUI

enum GameStateInfo {
    case started
    case waitingForPlayer
    case finished
}

struct GameNotification {
    static let waitingForPlayer = "Waiting for player"
    static let gameHasStarted = "Game has started"
    static let gameFinished = "Player left the game"
}
