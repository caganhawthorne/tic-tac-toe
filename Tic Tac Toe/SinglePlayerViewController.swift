//
//  SinglePlayerViewController.swift
//  Tic Tac Toe
//
//  Created by caganhawthorne on 7/2/15.
//  Copyright © 2015 Cagan Hawthorne. All rights reserved.
//

import UIKit
import SpriteKit

class SinglePlayerViewController: UIViewController {

    @IBOutlet weak var gridImage0: GridImage!
    
    @IBOutlet weak var gridImage2: GridImage!
   
    @IBOutlet weak var gridImage1: GridImage!
   
    @IBOutlet weak var gridImage3: GridImage!
    
    @IBOutlet weak var gridImage4: GridImage!
    
    @IBOutlet weak var gridImage5: GridImage!
    
    @IBOutlet weak var gridImage6: GridImage!
    
    @IBOutlet weak var gridImage7: GridImage!
    
    @IBOutlet weak var gridImage8: GridImage!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var dogePic: UIImageView!
    
    let wins = [ [0,3,6],[1,4,7],[2,5,8],[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6]]
    var imageArray: [GridImage]!
    var dogeTurn = true
    var dogeArray = [Int]()
    var grumpyCatArray = [Int]()

    @IBOutlet var dogeGestureRecognizer: UIPanGestureRecognizer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = [gridImage0, gridImage1, gridImage2, gridImage3, gridImage4, gridImage5, gridImage6, gridImage7, gridImage8]
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
    
    func reset() {
        for image in imageArray{
            image.isEmpty=true
            image.image = nil
        }
        grumpyCatArray.removeAll()
        dogeArray.removeAll()
        dogeTurn = true
    }
    
    func alertMessage(value:String) {
        let alert = UIAlertController(title: "Game Over!", message: value, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Play Again", style: .Destructive, handler: nil)
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    //@IBAction func imageWasTapped(sender: UITapGestureRecognizer) {
    
    @IBAction func dogeWasDragged(sender: UIPanGestureRecognizer) {
    if (sender.state == UIGestureRecognizerState.Ended) {
            for image in imageArray{
                if(CGRectContainsPoint(image.frame, sender.locationInView(backgroundView)) && image.isEmpty){
                    if(dogeTurn) {
                        image.image=UIImage(named: ("doge"))
                        dogeTurn = false
                        image.isEmpty = false
                        dogeArray.append(imageArray.indexOf(image)!)
                    }
                }
            }
        
        }
        
        
            if checkForWinner() == 1{
                alertMessage("DOGE WINS! CONGRATS!")
                reset()
                
            }
        
                
            else if ((dogeArray.count+grumpyCatArray.count) == 9) {
                alertMessage("\"Grumpy\" Cat's Game!")
                reset()
                
                
            }
            else if(!dogeTurn) {
                aiTurn()
                if checkForWinner() == 2 {
                    alertMessage("GRUMPY CAT WINS!...and is mad about it")
            
                    reset()
                    
            }
        }
    }
    
    func aiTurn()  {
        var index = -1
        //blocks if necessary
        for group in wins {
            var dogeCounter = 0
            for num in group {
                if dogeArray.contains(num){
                    dogeCounter++
                }
            }
            if (dogeCounter == 2){
                for num in group {
                    if (imageArray[num].isEmpty){
                        index = num
                    }
                }
            }
        }
        for group in wins {
            var catCounter = 0
            for num in group {
                if grumpyCatArray.contains(num){
                    catCounter++
                }
            }
            if (catCounter == 2){
                for num in group {
                    if (imageArray[num].isEmpty){
                        index = num
                    }
                }
            }
        }
        // win overrides block if possible
        if(index == -1){
            //index to center if empty
            if(imageArray[4].isEmpty){
                index = 4
            }
            else{ //index to random empty space
                repeat{
                index = Int(arc4random_uniform(8))
                } while(!imageArray[index].isEmpty)
            }
        }
        imageArray[index].image = UIImage(named: "grumpycat")
        dogeTurn = true
        imageArray[index].isEmpty = false
        grumpyCatArray.append(index)
        
    }

    
}
    
    





