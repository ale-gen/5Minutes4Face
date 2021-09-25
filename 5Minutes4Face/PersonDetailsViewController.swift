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
    
    @IBAction func addTimeButtonPressed(_ sender: UIButton) {
    }
    
}
