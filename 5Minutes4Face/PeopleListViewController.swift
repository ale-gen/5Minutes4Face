//
//  ViewController.swift
//  5Minutes4Face
//
//  Created by Aleksandra Generowicz on 25/09/2021.
//

import UIKit

class PeopleListViewController: UIViewController {
    
    var peopleList = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleList = CoreDataHelper.loadPeopleList()
    }
    
    @IBAction func addPersonButtonPressed(_ sender: UIBarButtonItem) {
        //TODO: Create image picker here
    }
    
}

extension PeopleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Set custom cells
        return UITableViewCell()
    }
    
    
}

