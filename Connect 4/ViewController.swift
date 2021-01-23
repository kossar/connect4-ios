//
//  ViewController.swift
//  Connect 4
//
//  Created by user184871 on 11/20/20.
//

import UIKit

class ViewController: UIViewController {
    
    var redScore = 0
    var yellowScore = 0
    var game: Connect4 = Connect4()
    
    @IBOutlet weak var GameBoard: UIStackView!
    @IBOutlet weak var RedScore: UILabel!
    @IBOutlet weak var YellowScore: UILabel!
    
    @IBAction func ResetTouchUpInside(_ sender: UIButton) {
        resetThisGame()
        redScore = 0
        yellowScore = 0
        RedScore.text = "\(redScore)"
        YellowScore.text = "\(yellowScore)"
        
    }
    @IBOutlet weak var NextTurnLabel: UILabel!
    
    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var ResetButtonOutlet: UIButton!
    @IBOutlet weak var NewGameButtonOutlet: UIButton!
    
    var buttonCounter = 0
    
    var colCounter = 0
    var gameStarted = false
    @IBAction func NewGameButtonAction(_ sender: UIButton) {
        if gameStarted {
            resetThisGame()
            
        } else {
            NewGameButtonOutlet.setTitle(Constants.ButtonNewGame.resetGame, for: UIControl.State.normal)
            game.resetGameBoard()
            updadeUI()
            InfoLabel.text = Constants.Info.nextTurn
            NextTurnLabel.text = game.nextMoveByRed ? Constants.Player.red : Constants.Player.yellow
            gameStarted = true
        }
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("\(String(describing: sender?.view?.tag))")
        if gameStarted {
            
            let moveResult = game.move(columnNo: (sender?.view!.tag)!)
            
            if  moveResult == MoveResult.success {
                updadeUI()
                NextTurnLabel.text = game.nextMoveByRed ? Constants.Player.red : Constants.Player.yellow
            } else if moveResult == MoveResult.win {
                
                InfoLabel.text = Constants.Info.winner
                if game.nextMoveByRed {
                    redScore += 1
                } else {
                    yellowScore += 1
                }
                RedScore.text = "\(redScore)"
                YellowScore.text = "\(yellowScore)"
                gameStarted = false
                NewGameButtonOutlet.setTitle(Constants.ButtonNewGame.newGame, for: UIControl.State.normal)
                updadeUI()
            }
        }
        
    }
    
    
    func createGameButton(buttonStatus: ButtonStatus) -> UIGameButtonView {
        let gameButton = UIGameButtonView()
        gameButton.showElement = buttonStatus.rawValue
        gameButton.tag = buttonCounter
        gameButton.backgroundColor = UIColor.clear
        
        buttonCounter += 1

        return gameButton
    }
    
    func createStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8.0
        stack.tag = colCounter
        colCounter += 1
        stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_: ))))
        return stack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updadeUI()
        ResetButtonOutlet.setTitle(Constants.ButtonReset.resetAll, for: UIControl.State.normal)
        NewGameButtonOutlet.setTitle(Constants.ButtonNewGame.newGame, for: UIControl.State.normal)
        
    }
    
    func updadeUI() {
        
        buttonCounter = 0
        colCounter = 0
        
        GameBoard.subviews.forEach({ $0.removeFromSuperview() })
        
        let board = game.getBoard()
        for col in 0..<board.count {
            let colStack = createStackView()
            GameBoard.addArrangedSubview(colStack)
            
            for row in 0 ..< board[col].count {
                //print("\(board[col][row])")
                let gameButton = createGameButton(buttonStatus: board[col][row])
                colStack.addArrangedSubview(gameButton)
            }
        }
    }
    
    func resetThisGame() {
        game.resetGameBoard()
        gameStarted = false
        NewGameButtonOutlet.setTitle(Constants.ButtonNewGame.newGame, for: UIControl.State.normal)
        updadeUI()
        NextTurnLabel.text = game.nextMoveByRed ? Constants.Player.red : Constants.Player.yellow
        InfoLabel.text = Constants.Info.nextTurn
    }



}
