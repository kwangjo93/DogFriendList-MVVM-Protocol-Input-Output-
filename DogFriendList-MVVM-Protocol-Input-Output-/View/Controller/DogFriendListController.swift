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
    @IBOutlet weak var eatLabel: UILabel!
    @IBOutlet weak var walkLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    var disposeBag: DisposeBag = DisposeBag()
    let dogFriendListVM = DogFriendListViewModel()
    lazy var addListVM = AddListViewModel(observableListData: dogFriendListVM.observableListData)
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        petListTableView.dataSource = self
        petListTableView.delegate = self
        bindViewModel()
    }
    
    // MARK: - Helper
    private func bindViewModel() {
        let input = DogFriendListViewModel.Input(plusButtonTap: plusButton.rx.tap,
                                                 listData: dogFriendListVM.observableListData)
        let output = dogFriendListVM.transform(input: input)

        output.plusButtonTap
            .withUnretained(self)
            .subscribe { _, _ in
                self.goToNextVC()
            }
            .disposed(by: disposeBag)
        
        output.listData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.petListTableView.reloadData()
            })
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

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DogFriendListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let pet = addListVM.listData[section].pet
        return pet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DogFriendListTableViewCell.identifier, for: indexPath) as! DogFriendListTableViewCell
        let person = addListVM.listData[indexPath.section]
        let pet = person.pet[indexPath.row]
        cell.pet = pet
        cell.eatActionData = { [weak self] data in
            self?.eatLabel.text = data
        }
        cell.walkActionData = { [weak self] data in
            self?.walkLabel.text = data
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addListVM.listData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return addListVM.listData[section].name
    }
}
