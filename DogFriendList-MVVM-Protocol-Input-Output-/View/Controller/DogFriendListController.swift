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
        plusButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.goToNextVC()
            })
            .disposed(by: disposeBag)
        
        let input = DogFriendListViewModel.Input(listData: addListVM.observableListData)
        let output = dogFriendListVM.transform(input: input)
        
        output.listData?
            .bind(to: petListTableView.rx.items(cellIdentifier: DogFriendListTableViewCell.identifier)) { index, model, cell in
                if let dogFriendCell = cell as? DogFriendListTableViewCell {
                    dogFriendCell.configure(with: model, index: index)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func goToNextVC() {
        let storyboard = UIStoryboard(name: "AddView", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "AddListViewController") as? AddListViewController {
            nextVC.addListVM = addListVM
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
        }
    }
}

