//
//  GameView.swift
//  TicTacToe
//
//  Created by Jan Podmolík on 26.09.2021.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text(viewModel.gameNotification)
                GameButton(title: "Quit", backgroundColor: .red) {
                    viewModel.quitGame()
                    presentation.wrappedValue.dismiss()
                }
                .padding()
                
                Spacer()
                
                VStack {
                    LazyVGrid(columns: viewModel.columns, spacing: 0) {
                        ForEach(0..<25) { index in
                            ZStack {
                                GameSquareView(proxy: proxy)
                                PlayerIndicatorView(systemImageName: viewModel.getIndicator(for: index))
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: index)
                            }
                        }
                    }
                    .border(.white, width: 1)
                }
                .disabled(false)


                Spacer()
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .destructive(alertItem.buttonTitle) {
                    presentation.wrappedValue.dismiss()
                    viewModel.quitGame()
                })
            }
        }
        .padding()
        .onAppear {
            viewModel.findGame()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
