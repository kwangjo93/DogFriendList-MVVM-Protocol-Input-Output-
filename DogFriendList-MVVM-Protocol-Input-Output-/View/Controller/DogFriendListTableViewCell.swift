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
    @IBOutlet weak var petActionButton: UIButton!
    var pet: Pet? {
        didSet {
            configure()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure() {
        guard let pet = pet else { return }
        dump(pet.name)
        petLabel.text = pet.name
    }
}
