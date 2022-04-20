//
//  ContentView.swift
//  Paper Rock and Scissors
//
//  Created by Iuliia Bondarenko on 13.04.2022.
//

import SwiftUI
extension Color{
    static let lightGray = Color(red: 0.94, green: 0.94, blue: 0.95)
    static let darkerGray = Color(red: 0.92, green: 0.92, blue: 0.93)
}

struct NeumorphicButtonStyle: ButtonStyle{
    func makeBody(configuration: Self.Configuration)-> some View {
        configuration.label
            .padding(25)
            .background(
                Group{
                    if(configuration.isPressed){
                    Circle()
                        .fill(Color.lightGray)
                      
                }
                else{
                    Circle()
                        .fill(Color.lightGray)
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)

                    }
                    
                }
            )
    }
    
    
}

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
        ZStack{
            Color.lightGray
                .ignoresSafeArea()
        VStack{
        Text("Score: \(score)")
            Spacer()
            VStack{
            Image(systemName: String(gameMove == moves.paper ? "doc.fill": gameMove == moves.rock ? "oval.fill" : "scissors")).font(.largeTitle)
            Text(isWin ? "Win" : "Loose")
            }.frame(maxWidth: .infinity, maxHeight: 200)
                .background(Color.lightGray)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
                .cornerRadius(20)
                .overlay{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 4)
                        .blur(radius: 4)
                        .offset(x: 2, y: 2)
                        .mask(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors : [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomLeading)))
                        .overlay{
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(Color.white, lineWidth: 8)
                                               .blur(radius: 4)
                                               .offset(x: -2, y: -2)
                                               .mask(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors : [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomLeading)))


                                       }
                                   

                }
               
            
            Spacer()
          
            HStack(spacing: 35){
        
                Button {
                    calculateScore(playerMove:  moves.rock)
                    newMove()
                }label:{
                    Image(systemName: "doc.fill")
                    }.buttonStyle(NeumorphicButtonStyle())
                    
                Button{
                    calculateScore(playerMove:  moves.rock)
                    newMove()
                }label: {
                    Image(systemName: "oval.fill")
                }.buttonStyle(NeumorphicButtonStyle())
                Button{
                    calculateScore(playerMove:  moves.scissors)
                    newMove()
                }label: {
                    Image(systemName: "scissors")
                }.buttonStyle(NeumorphicButtonStyle())
                
            }.padding()
        }.padding()
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
