//
//  PersonTableViewCell.swift
//  5Minutes4Face
//
//  Created by Aleksandra Generowicz on 25/09/2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var leftTimeLabel: UILabel!
    
    var person: Person? {
        didSet {
            personImageView.image = UIImage(data: (person?.image)!)
            setTimeLabelColor()
            updateTime()
        }
    }
    
    func setTimeLabelColor() {
        guard let person = person else {
            return
        }
        
        if person.finished {
            leftTimeLabel.textColor = .red
        } else {
            leftTimeLabel.textColor = .black
        }
    }
    
    func updateTime() {
        guard let person = person else {
            return
        }
    
        setTimeLabelColor()
        
        if person.finished {
            leftTimeLabel.text = "Time's up"
        } else {
            let totalLeftTime = person.totalDurationTime
            if totalLeftTime > 0 {
                let leftMinutes = totalLeftTime / 60
                let leftSeconds = totalLeftTime % 60
                
                leftTimeLabel.text = "\(leftMinutes)m \(leftSeconds)s"
                person.totalDurationTime -= 1
            } else {
                person.finished = true
            }
        }
    }

}
