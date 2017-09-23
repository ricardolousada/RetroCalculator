//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ricardo Lousada on 23/09/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var outPutLable: UILabel!
    
    
    enum Operation: String {

        case Divide = "/"
        case Multiply =  "*"
        case Subtract = "-"
        case Add  = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var btnSound: AVAudioPlayer!
    var runningNunber = ""
    var leffValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.description)
        }
        outPutLable.text = "0"
    }

  
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNunber += "\(sender.tag)"
        outPutLable.text = runningNunber
    }
    
    
    @IBAction func onDividePressed(sender: UIButton){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: UIButton){
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: UIButton){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEquaalPressed(sender: UIButton){
        processOperation(operation: currentOperation)
    }
    
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            //A user selected an operator and there is altredy a left side number
            if runningNunber != "" {
                rightValStr = runningNunber
                runningNunber = ""
                
                switch currentOperation {
                case .Multiply:
                    result = "\(Double(leffValStr)! * Double(rightValStr)!)"
                case .Divide:
                    result = "\(Double(leffValStr)! / Double(rightValStr)!)"
                case .Subtract:
                    result = "\(Double(leffValStr)! - Double(rightValStr)!)"
                case .Add:
                    result = "\(Double(leffValStr)! + Double(rightValStr)!)"
                default:
                    return
                }
                
                leffValStr = result
                outPutLable.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has ben pressed
            leffValStr = runningNunber
            runningNunber = ""
            currentOperation = operation
            
        }
    
    }

}

