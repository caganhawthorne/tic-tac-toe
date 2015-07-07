//
//  TwoPlayerViewController.swift
//  Tic Tac Toe
//
//  Created by caganhawthorne on 7/2/15.
//  Copyright © 2015 Cagan Hawthorne. All rights reserved.
//

import UIKit

class TwoPlayerViewController: UIViewController {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var gridImage0: GridImage!
    
    @IBOutlet weak var gridImage1: GridImage!
 
    @IBOutlet weak var gridImage2: GridImage!
    
    @IBOutlet weak var gridImage3: GridImage!
    
    @IBOutlet weak var gridImage4: GridImage!
    
    @IBOutlet weak var gridImage5: GridImage!
    
    @IBOutlet weak var gridImage6: GridImage!
    
    @IBOutlet weak var gridImage7: GridImage!
    
    @IBOutlet weak var gridImage8: GridImage!
    
    var imageArray: [GridImage]!
    
    var dogeTurn = true
    var dogeArray = [Int]()
    var grumpyCatArray = [Int]()
    
    
    let wins = [ [0,3,6],[1,4,7],[2,5,8],[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray=[gridImage0,gridImage1,gridImage2,gridImage3,gridImage4,gridImage5,gridImage6,gridImage7,gridImage8]
        playerLabel.text = "DOGE'S TURN"
        
        
    }
    
    @IBAction func screenWasTapped(sender: UITapGestureRecognizer) {
        
        for image in imageArray{
            if(CGRectContainsPoint(image.frame, sender.locationInView(backGroundView)) && image.isEmpty){
                if(dogeTurn) {
                    image.image=UIImage(named: ("doge"))
                    dogeTurn = !dogeTurn
                    image.isEmpty = false
                    playerLabel.text = "GRUMPY CAT'S TURN"
                    dogeArray.append(imageArray.indexOf(image)!)
                    
                    
                    
                }
                else {
                    image.image=UIImage(named: ("grumpycat"))
                    dogeTurn = !dogeTurn
                    image.isEmpty = false
                    playerLabel.text = "DOGE'S TURN"
                    grumpyCatArray.append(imageArray.indexOf(image)!)
                }


            }
            print(dogeArray)
            print(grumpyCatArray)
            if checkForWinner() == 1{
                alertMessage("DOGE WINS!")
                reset()
            }
            else if checkForWinner() == 2{
                alertMessage("GRUMPY CAT WINS!")

                    reset()
                
            }
            
            else if ((dogeArray.count+grumpyCatArray.count) == 9) {
                alertMessage("\"Grumpy\" Cat's Game!")
                reset()

                
            }
            

        }

    }
    
    func checkForWinner() -> Int{
        for group in wins {
            var dogeCounter = 0
            var catCounter = 0
            for num in group {
                
                if dogeArray.contains(num){
                    dogeCounter++
                }
                if grumpyCatArray.contains(num){
                    catCounter++
                }
            
                
            }
            if (dogeCounter == 3){
                return 1
            }
            if (catCounter == 3){
                return 2
            }
        }
        
        return 0
    }
    
    func alertMessage(value:String) {
        let alert = UIAlertController(title: "Game Over!", message: value, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Play Again", style: .Destructive, handler: nil)
        alert.addAction(action)
            
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func reset() {
        for image in imageArray{
            image.isEmpty=true
            image.image = nil
            grumpyCatArray.removeAll()
            dogeArray.removeAll()
            dogeTurn = true
            playerLabel.text = ""
        }

    }


}
