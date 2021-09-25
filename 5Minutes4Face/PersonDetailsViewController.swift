//
//  PersonDetailsViewController.swift
//  5Minutes4Face
//
//  Created by Aleksandra Generowicz on 25/09/2021.
//

import UIKit
import MKStepper

class PersonDetailsViewController: UIViewController {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var currentLeftTimeLabel: UILabel!
    @IBOutlet weak var minutesStepperView: MKStepperView!
    
    var person: Person? {
        didSet {
            personImageView.image = UIImage(data: (person?.image)!)
            setTimeLabelColor()
        }
    }
    
    override func viewDidLoad() {
        minutesStepperView.stepperValue = 5
        minutesStepperView.layer.cornerRadius = 0.2
    }
    
    func setTimeLabelColor() {
        guard let person = person else {
            return
        }
        
        if person.finished {
            currentLeftTimeLabel.textColor = .red
            currentLeftTimeLabel.text = "Time's up"
        } else {
            currentLeftTimeLabel.textColor = .black
            updateTimeLabel()
        }
    }
    
    func updateTimeLabel() {
        guard let person = person else {
            return
        }
        
        let totalLeftTime = person.totalDurationTime
        if totalLeftTime > 0 {
            let leftMinutes = totalLeftTime / 60
            let leftSeconds = totalLeftTime % 60
            
            currentLeftTimeLabel.text = "\(leftMinutes)m \(leftSeconds)s"
            person.finished = false
        } else {
            person.finished = true
        }
    }
    
    @IBAction func addTimeButtonPressed(_ sender: UIButton) {
    }
    
}
