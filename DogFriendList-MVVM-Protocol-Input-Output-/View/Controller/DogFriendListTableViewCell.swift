//
//  DogFriendListTableViewCell.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa

class DogFriendListTableViewCell: UITableViewCell {
    static let identifier = "DogFriendListTableViewCell"
    @IBOutlet weak var petLabel: UILabel!
    @IBOutlet weak var petActionButton: UIButton!
    private var disposeBag = DisposeBag()
    var eatActionData: ((String) -> Void)?
    var walkActionData: ((String) -> Void)?
    var pet: Animal? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        petLabel.numberOfLines = 0
        petLabel.lineBreakMode = .byWordWrapping
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure() {
        guard let pet = pet else { return }
        petActionButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let pet = self?.pet else { return }
                let eataction: String = pet.eat()
                let walkaction: String = pet.walkTogether()
                self?.eatActionData?(eataction)
                self?.walkActionData?(walkaction)
            })
            .disposed(by: disposeBag)
        petLabel.text = pet.name
    }
}
