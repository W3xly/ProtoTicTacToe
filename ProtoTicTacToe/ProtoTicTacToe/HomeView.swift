//
//  HomeView.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 26.09.2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            GameButton(title: "PLAY", backgroundColor: .green) {
                viewModel.isGameViewPresented = true
            }
        }
        .fullScreenCover(isPresented: $viewModel.isGameViewPresented) {
            GameView(viewModel: GameViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
 
