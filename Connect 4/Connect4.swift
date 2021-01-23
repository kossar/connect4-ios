//
//  GameEngine.swift
//  Connect 4
//

import Foundation

public class Connect4 {
    
    var gameBoard: [[ButtonStatus]] = Array(repeating: Array(repeating: ButtonStatus.empty, count: 6), count: 7)
    
    var nextMoveByRed = true
    
    var winCombination: [[Int]] = Array(repeating: Array(repeating: 0, count: 2), count: 4)
    
    func move(columnNo col: Int) -> MoveResult{
        if gameBoard[col][0] != ButtonStatus.empty {
            return MoveResult.fail
        }
        for i in 0..<gameBoard[col].count {
            if gameBoard[col][i] != ButtonStatus.empty {
                self.gameBoard[col][i - 1] = nextMoveByRed ? ButtonStatus.player1 : ButtonStatus.player2
                break
            } else if i == gameBoard[col].count - 1 {
                gameBoard[col][gameBoard[col].count - 1] = nextMoveByRed ? ButtonStatus.player1 : ButtonStatus.player2
            }
        }
        
        if checkColsForWin() ||
            checkRowsForWin() ||
            checkDiagonalsForWin(bottomLeftToUpperRight: true) ||
            checkDiagonalsForWin(bottomLeftToUpperRight: false) {
            
            return MoveResult.win
        }
        nextMoveByRed = !nextMoveByRed
        return MoveResult.success
    }
    
    func checkRowsForWin() -> Bool{
        var flippedBoard = Array(repeating: Array(repeating: ButtonStatus.empty, count: 7), count: 6)

        var positions = Array(repeating:
                                Array(repeating:
                                        Array(repeating: 0, count: 2),
                                      count: 7),
                              count: 6)
        
        for i in 0..<gameBoard[0].count {
            for j in 0..<gameBoard.count {
                flippedBoard[i][j] = gameBoard[j][i]
                positions[i][j] = [j, i]
            }
        }
        
        if checkSubArray(board: flippedBoard) == true {
            for i in 0..<winCombination.count {
                //Cols and rows from modified board
                let col = winCombination[i][0]
                let row = winCombination[i][1]
                //Cols and rows from correct board
                let correctCol = positions[col][row][0]
                let correctRow = positions[col][row][1]
                gameBoard[correctCol][correctRow] = ButtonStatus.win
            }
            return true
        }
        

        return false
    }
    
    func checkColsForWin() -> Bool {
      
        if checkSubArray(board: gameBoard) == true {
            for i in 0..<winCombination.count {
                let col = winCombination[i][0]
                let row = winCombination[i][1]
                gameBoard[col][row] = ButtonStatus.win
            }
            return true
        }
        
        return false
    }
    
    func checkSubArray(board: [[ButtonStatus]] ) -> Bool {
        //Create arrays to compare with
        let player1Win = Array(repeating: ButtonStatus.player1, count: 4)
        let player2Win = Array(repeating: ButtonStatus.player2, count: 4)
        
        for col in 0..<board.count{
            for row in 0..<board[col].count - 3 {
                var compareFour: [ButtonStatus] = Array(repeating: ButtonStatus.empty, count: 4)
                for i in 0..<4 {
                    compareFour[i] = board[col][row + i]
                    winCombination[i] = [col, row + i]
                }
                if compareFour.elementsEqual(player1Win) || compareFour.elementsEqual(player2Win) {
                    return true
                }
                
            }
            
        }
        
        return false
    }
    
   
    func checkDiagonalsForWin(bottomLeftToUpperRight: Bool) -> Bool{
        var diagonalBoard = gameBoard

        //val positionMap = IntArray(7){it + 1}

        if !bottomLeftToUpperRight {
            for row in 0..<gameBoard.count {
                diagonalBoard[row] = gameBoard[row].reversed()
            }
        } else {
            diagonalBoard = gameBoard
        }

        let width = gameBoard[0].count
        let height = gameBoard.count

        var counter = 0
        var items = Array(repeating: ButtonStatus.empty, count: 6)
        var positions = Array(repeating: Array(repeating: 0, count: 2), count: width)

        for k in 0..<width + height - 1 {
            for j in 0..<k + 1 {
                let i = k - j
                if i < height && j < width {
                    items[counter] = diagonalBoard[i][j]
                    if (!bottomLeftToUpperRight) {
                        positions[counter] = [i, width - j - 1]
                    }else {
                        positions[counter] = [i, j]
                    }
                    counter += 1
                }
            }
            if checkSubArray(board: Array(repeating: items, count: 1)) {
                print("\(items)")
                for i in 0..<positions.count {
                    let col = positions[i][0]
                    let row = positions[i][1]
                    print(row)
                    if nextMoveByRed && gameBoard[col][row] == ButtonStatus.player1{
                        gameBoard[col][row] = ButtonStatus.win
                    } else if !nextMoveByRed && gameBoard[col][row] == ButtonStatus.player2 {
                        gameBoard[col][row] = ButtonStatus.win
                    }
                    
                }
                return true
            }
            print("\(counter)")
            items = Array(repeating: ButtonStatus.empty, count: 6)
            counter = 0
        }
       
        return false
    }
    
    func getBoard() -> [[ButtonStatus]] {
        return gameBoard
    }
    func resetGameBoard() {
        gameBoard = Array(repeating: Array(repeating: ButtonStatus.empty, count: 6), count: 7)
        nextMoveByRed = true
    }
}
