//
//  CardGameVC.swift
//  PokerZoneLili
//
//  Created by PokerZoneLili on 2025/3/7.
//


import UIKit

class LiliCardGameViewController: UIViewController {

    @IBOutlet weak var p1Card: UIImageView!
    @IBOutlet weak var p2Card: UIImageView!
    
    @IBOutlet weak var p1CounterLbl: UILabel!
    @IBOutlet weak var p2CounterLbl: UILabel!
    
    @IBOutlet weak var p1ScoreLbl: UILabel!
    @IBOutlet weak var p2ScoreLbl: UILabel!

    var cardImg = ["A", "2", "3", "4", "5", "6", "7", "8", "9"]
    var counter = 8
    var p1Score = 0
    var p2Score = 0
    var imgAry: [Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounterLabels()
        updateScoreLabels()
    }
    
    @IBAction func rollBtn(_ sender: Any) {
        if counter == 0 {
            showFinalResult()
            return
        }
        
        counter -= 1
        
        let p1RandomCard = cardImg.randomElement()!
        let p2RandomCard = cardImg.randomElement()!
        
        animateCardFlip(imageView: p1Card, cardName: p1RandomCard)
        animateCardFlip(imageView: p2Card, cardName: p2RandomCard)
        
        checkWinner(p1Card: p1RandomCard, p2Card: p2RandomCard)
        
        updateCounterLabels()
        
        if counter == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.showFinalResult()
            }
        }
    }
    
    func updateCounterLabels() {
        p1CounterLbl.text = "\(counter) Left"
        p2CounterLbl.text = "\(counter) Left"
    }
    
    func updateScoreLabels() {
        p1ScoreLbl.text = "P1 Score: \(p1Score)"
        p2ScoreLbl.text = "P2 Score: \(p2Score)"
    }
    
    func animateCardFlip(imageView: UIImageView, cardName: String) {
        UIView.transition(with: imageView, duration: 0.5, options: .transitionFlipFromRight, animations: {
            imageView.image = UIImage(named: cardName)
        }, completion: { _ in
            self.animateCardBounce(imageView: imageView)
        })
    }
    
    func animateCardBounce(imageView: UIImageView) {
        UIView.animate(withDuration: 0.2, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                imageView.transform = .identity
            }
        }
    }
    
    func checkWinner(p1Card: String, p2Card: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            if self.counter == 0 {
                return  // Skip winner alert on the last move
            }
            
            var title = "Keep Playing! 🎲"
            var message = "Try again and see if you get an Ace!"
            
            if p1Card == "A" && p2Card == "A" {
                title = "It's a Draw! 🤝"
                message = "Both players got an Ace! Try again!"
            } else if p1Card == "A" {
                title = "Player 1 Wins! 🎉"
                message = "Congratulations! Player 1 got the Ace!"
                self.p1Score += 1
            } else if p2Card == "A" {
                title = "Player 2 Wins! 🏆"
                message = "Well played! Player 2 got the Ace!"
                self.p2Score += 1
            }
            
            self.updateScoreLabels()
            
            self.showAlert(title: title, message: message)
        }
    }
    
    func showFinalResult() {
        
        guard let img = view.toImage()?.pngData() else{
            return
        }
        arrHistory.append(img)
        
        var title = "Game Over! 🎮"
        var message = "It's a Draw! Both players played well!"
        
        if p1Score > p2Score {
            title = "🏆 Player 1 Wins the Game!"
            message = "Player 1 had the most wins in 8 rounds!"
        } else if p2Score > p1Score {
            title = "🥇 Player 2 Wins the Game!"
            message = "Player 2 dominated with the most wins!"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.resetGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetGame() {
        counter = 8
        p1Score = 0
        p2Score = 0
        p1Card.image = UIImage(named: "back card")
        p2Card.image = UIImage(named: "back card")
        updateCounterLabels()
        updateScoreLabels()
    }
}
