//
//  PersonTableViewCell.swift
//  Pair
//
//  Created by Bryson Jones on 5/21/21.
//

import UIKit


class PersonTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var personNameLabel: UILabel!
    
    //MARK: - Properties
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let person = person else {return}
        personNameLabel.text = person.name
    }
}//End class
