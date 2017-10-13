//
//  ViewController.swift
//  TopUp
//
//  Created by Apple on 12/10/2017.
//  Copyright © 2017 Qilobyt. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var cardOneLabel: UILabel!
    @IBOutlet weak var cardTwoLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var attemptLabel: UILabel!
    
    var flips = 5
    var playerScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        playGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var myAudio: AVAudioPlayer!
    
    func sound(){
    let path = Bundle.main.path(forResource: "Ting Sound", ofType: "mp3")
    let url = URL(fileURLWithPath: path!)
    do {
    let sound = try AVAudioPlayer(contentsOf: url)
    myAudio = sound
    sound.play()
    } catch {
    print("No sound file found!")
    }
    }
    
    func endGame()
    {
        let alertController = UIAlertController(title: "Out of tries.TopScore:\(playerScore)", message: "Play Again?", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            
        }
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            self.playGame()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func flipCard(_ sender: UIButton)
    {
        let rand = Int(arc4random_uniform(11))
        cardTwoLabel.backgroundColor = UIColor.white
        cardTwoLabel.text = String(rand)
        flips -= 1
        attemptLabel.text = "\(flips) flips left"
        if (Int(cardTwoLabel.text!)! + Int(cardOneLabel.text!)!) >= 10 && flips > 0{
            playerScore += 10
            winLabel.text = "Score:\(playerScore)"
            sound()
            starImage.isHidden = false
        }else if flips == 0 {
            attemptLabel.text = "\(flips) flips left"
            endGame()
        }else{ starImage.isHidden = true }
    }

    func playGame(){
      let rand = Int(arc4random_uniform(11))
        cardTwoLabel.backgroundColor = UIColor.green
      cardOneLabel.text = String(rand)
      cardTwoLabel.text = ""
        playerScore = 0
      winLabel.text = "Score:\(playerScore)"
      starImage.isHidden = true
        flips = 5
      attemptLabel.text = "\(flips) flips"
      
    }
    
    @IBAction func newGame(_ sender: UIButton)
    {
        playGame()
    }
    

}

