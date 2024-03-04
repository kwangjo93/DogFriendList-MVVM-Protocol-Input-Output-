//
//  DogFriendListController.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa

class DogFriendListController: UIViewController {
    // MARK: - Property
    @IBOutlet weak var petListTableView: UITableView!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    var disposeBag: DisposeBag = DisposeBag()
    let dogFriendListVM = DogFriendListViewModel()
    let addListVM = AddListViewModel()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - Helper
    private func bindViewModel() {
        let input = DogFriendListViewModel.Input()
        
        let output = dogFriendListVM.transform(input: input)
        
        plusButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.goToNextVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func goToNextVC() {
        let storyboard = UIStoryboard(name: "AddView", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "AddListViewController") as? AddListViewController {
            nextVC.addListVM = addListVM
            self.present(nextVC, animated: true, completion: nil)
        }
    }
}

