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
    
    var timer: Timer?
    var person: Person?
    
    override func viewDidLoad() {
        minutesStepperView.stepperValue = 5
        minutesStepperView.layer.cornerRadius = 0.2
        setupPersonDetails()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    func setupPersonDetails() {
        guard let person = person else {
            return
        }
        
        personImageView.image = UIImage(data: person.image!)
        createTimer()
    }
    
    func createTimer() {
        if timer == nil {
          let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
          RunLoop.current.add(timer, forMode: .common)
          timer.tolerance = 0.1
            print("Create timer: \(person?.finished)")
    
          self.timer = timer
        }
    }
    
    func setTimeLabelColor() {
        guard let person = person else {
            return
        }
        
        if person.finished {
            currentLeftTimeLabel.textColor = .red
            currentLeftTimeLabel.text = "Time's up"
            stopTimer()
        } else {
            currentLeftTimeLabel.textColor = .black
            updateTimeLabel()
        }
    }
    
    @objc func updateTime() {
        setTimeLabelColor()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateTimeLabel() {
        guard let person = person else {
            return
        }
        
        if !person.finished {
            let currentTimeInSeconds = Int64(Date().timeIntervalSince(person.startedTime!))
            let totalLeftTime = person.totalDurationTime - currentTimeInSeconds
            if totalLeftTime > 0 {
                let leftMinutes = totalLeftTime / 60
                let leftSeconds = totalLeftTime % 60
                
                currentLeftTimeLabel.text = "\(leftMinutes)m \(leftSeconds)s"
            } else {
                person.finished = true
                person.totalDurationTime = 0
            }
        }
        
    }
    
    @IBAction func addTimeButtonPressed(_ sender: UIButton) {
        guard let person = person else {
            return
        }
        
        let timeToAdd = minutesStepperView.stepperValue * 60
        
        person.totalDurationTime += Int64(timeToAdd)
        if person.finished {
            person.startedTime = Date()
        }
        person.finished = false
        createTimer()
    }
    
}
