//
//  PersonListTableViewController.swift
//  Pair
//
//  Created by Bryson Jones on 5/21/21.
//

import UIKit

class PersonListTableViewController: UITableViewController {
    @IBOutlet var personListTableView: UITableView!
    
    //MARK: - Properties
    var person: Person?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        personListTableView.delegate = self
        personListTableView.dataSource = self
        PersonController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        personListTableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func addBarButtonTapped(_ sender: Any) {
        presentAddPersonAlert()
    }
    @IBAction func shuffleBarButtonTapped(_ sender: Any) {
        PersonController.shared.randomizePeople()
        tableView.reloadData()
    }
    
    
    //MARK: - Helper Methods
    func presentAddPersonAlert() {
        let alertController = UIAlertController(title: "Add Person", message: "Who?", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter their name..."
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else {return}
            PersonController.shared.createPersonWith(name: name)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        personListTableView.reloadData()
    }
    
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return PersonController.shared.sections.count
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
        //PersonController.shared.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell else {return UITableViewCell()}
        
        let person = PersonController.shared.people[indexPath.row]
        //let person = PersonController.shared.sections[indexPath.section][indexPath.row]
        
        cell.person = person
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personToDelete = PersonController.shared.people[indexPath.row]
            //PersonController.shared.sections[indexPath.section][indexPath.row]
            PersonController.shared.deletePerson(person: personToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Group 1"
//        } else if section == 1 {
//            return "Group 2"
//        } else if section == 2 {
//            return "Group 3"
//        } else if section == 3 {
//            return "Group 4"
//        } else if section == 4 {
//            return "Group 5"
//        }
//        return nil
//    }
}//End class


