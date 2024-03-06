//
//  AddListViewController.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import UIKit
import RxSwift
import RxCocoa

class AddListViewController: UIViewController {
    @IBOutlet weak var friendNameTextField: UITextField!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petSpeciesPicker: UIPickerView!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var addListVM: AddListViewModel?
    var disposeBag: DisposeBag = DisposeBag()
    let pickerData = ["햄스터", "라쿤", "물고기", "토끼", "새", "원숭이", "개", "고양이"]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        petSpeciesPicker.delegate = self
        petSpeciesPicker.dataSource = self
        bindViewModel()
    }
    
    // MARK: - Helper
    private func bindViewModel() {
        guard let addListVM = addListVM else { return }
        let input = AddListViewModel.Input(friendName: friendNameTextField.rx.text,
                                           petname: petNameTextField.rx.text,
                                           selectedValue: addListVM.selectedValue,
                                           saveButtonTap: saveButton.rx.tap,
                                           backBUttonTap: backButton.rx.tap)
        
        let output = addListVM.transform(input: input)
        
        output.backBUttonTap
            .withUnretained(self)
            .subscribe { _, _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        output.selectedValue
            .subscribe(onNext: { [weak self] selectedValue in
                guard let self = self else { return }
                let petImage = self.addListVM?.getSelectedImage(selectedValue: selectedValue ?? "")
                self.petImageView.image = petImage
            })
            .disposed(by: disposeBag)
        
        output.saveButtonTap
            .withUnretained(self)
            .subscribe { _, _ in
                addListVM.saveListData(view: self)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension AddListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = pickerData[row]
        addListVM?.selectedValue.onNext(selectedOption)
    }
    
}
