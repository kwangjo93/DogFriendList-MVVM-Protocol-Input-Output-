//
//  DogFriendListTableViewCell.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import UIKit

class DogFriendListTableViewCell: UITableViewCell {
    static let identifier = "DogFriendListTableViewCell"
    
    @IBOutlet weak var petLabel: UILabel!
    @IBOutlet weak var personLabel: UILabel!
    
    @IBOutlet weak var petActionButton: UIButton!
    
    
    @IBAction func plusButton(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with person: Person, index: Int) {
        if let firstPet = person.pet.first {
            personLabel.text = person.name
            petLabel.text = firstPet.name
        } else {
            personLabel.text = ""
            petLabel.text = person.pet[index].name
        }
    }
}
