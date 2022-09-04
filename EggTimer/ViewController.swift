//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

enum EggHardness: String {
    case soft = "soft", medium = "medium", hard = "hard"
    
    func title() -> String {
        switch self {
        case .soft:
            return "Soft"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
    
    func timeRequired() -> Int {
        switch self {
        case .soft:
            return 3
        case .medium:
            return 5
        case .hard:
            return 8
        }
    }
    
    static func allValues() -> [EggHardness] {
        return [.soft, .medium, .hard]
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimers: [EggHardness] = EggHardness.allValues()
        
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer()
    
    func reset() {
        self.secondsPassed = 0
        self.progressBar.progress = 0.0
    }
    

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        reset()
        
        let hardness = self.eggTimers[sender.tag]
        
        self.totalTime = hardness.timeRequired()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
            secondsPassed += 1
            
            let percentage = Double(secondsPassed) / Double(totalTime)
            progressBar.setProgress(Float(percentage), animated: true)
            
            debugPrint("secondsPassed: \(secondsPassed) totalSeconds: \(totalTime) percentage: \(percentage)")
            
            
        } else {
            timer.invalidate()
        }
    }
}
