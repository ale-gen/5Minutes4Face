//
//  ViewController.swift
//  5Minutes4Face
//
//  Created by Aleksandra Generowicz on 25/09/2021.
//

import UIKit

class PeopleListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let imagePicker = UIImagePickerController()
    
    var peopleList = [Person]()
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker.delegate = self
        
        peopleList = CoreDataHelper.loadPeopleList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        CoreDataHelper.savePeopleList()
    }
    
    @IBAction func addPersonButtonPressed(_ sender: UIBarButtonItem) {
        createTimer()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
}

//MARK: - TableView delegate methods
extension PeopleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! PersonTableViewCell
        cell.person = peopleList[indexPath.row]
        return cell
    }
    
    
}

//MARK: - Set chosen image as person's image
extension PeopleListViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage {
            let newPerson = Person(context: CoreDataHelper.context)
            newPerson.image = userPickedImage.jpegData(compressionQuality: 1.0)
            peopleList.append(newPerson)

            CoreDataHelper.savePeopleList()
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
}

//MARK: - Timer
extension PeopleListViewController {
    
    func createTimer() {
      if timer == nil {
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        print("Create timer")
        self.timer = timer
      }
    }
    
    @objc func updateTimer() {
      guard let visibleRowsIndexPath = tableView.indexPathsForVisibleRows else {
        return
      }
      
      for indexPath in visibleRowsIndexPath {
        if let cell = tableView.cellForRow(at: indexPath) as? PersonTableViewCell {
          cell.updateTime()
        }
      }


    }
}

