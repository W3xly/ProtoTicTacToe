//
//  AlertItem.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 28.09.2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var isForQuit = false
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    
    static let youWin = AlertItem(title: Text("You Win!"), message: Text("You are good at this game!"), buttonTitle: Text("Rematch"))
    static let youLost = AlertItem(title: Text("You Lost!"), message: Text("Try it again!"), buttonTitle: Text("Rematch"))
    static let draw = AlertItem(title: Text("Draw!"), message: Text("That was close!"), buttonTitle: Text("Rematch"))
    static let quit = AlertItem(isForQuit: true, title: Text("GameOver"), message: Text("Other player left"), buttonTitle: Text("Quit"))
}
