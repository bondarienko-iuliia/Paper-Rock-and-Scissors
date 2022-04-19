//
//  ContentView.swift
//  Paper Rock and Scissors
//
//  Created by Iuliia Bondarenko on 13.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State var gameMove = moves.paper
   @State var isWin = true
    @State var score = 0
    @State var showAlert = false
    enum moves: String, CaseIterable{
        case paper = "paper"
        case scissors = "scissors"
        case rock = "rock"
    }
    
    init(){
        newMove()
    }
    let winPairs = [moves.paper : moves.scissors, moves.rock : moves.paper, moves.scissors : moves.rock]
    func restartGame(){
        score = 0
        newMove()
    }
    func newMove(){
      gameMove = moves.allCases.randomElement()!
       isWin = Bool.random()
    }
    
//user won when
    func isPlayerWon (playerMove:moves)-> Bool{
        
        if let playeShouldChooseToWin = winPairs[gameMove], playeShouldChooseToWin == playerMove , isWin{
          return true
        }
        else if let playerSouldChooseToLoose = winPairs[playerMove], playerSouldChooseToLoose == gameMove {
            return true
        }
        return false
    }
    func calculateScore(playerMove:moves){
        if isPlayerWon(playerMove: playerMove){
            score += 1
            if score == 10{
                restartGame()
                showAlert = true
            }
        }

    }
    var body: some View {
        VStack{
        Text("Score: \(score)")
            Image(systemName: String(gameMove == moves.paper ? "doc.fill": gameMove == moves.rock ? "oval.fill" : "scissors"))
            Text(isWin ? "Win" : "Loose")
            HStack{
        
                Button{
                    calculateScore(playerMove:  moves.paper)
                    newMove()
                }label: {
                    Image(systemName: "doc.fill")
                }
                Button{
                    calculateScore(playerMove:  moves.rock)
                    newMove()
                }label: {
                    Image(systemName: "oval.fill")
                }
                Button{
                    calculateScore(playerMove:  moves.scissors)
                    newMove()
                }label: {
                    Image(systemName: "scissors")
                }
                
            }
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// on screen the card is flipping with image and text
// 3 buttons become  active
// alert about win or loose
// score is in the corner
// end te game with screen showing score
