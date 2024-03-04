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
    var addListVM: AddListViewModel?
    var disposeBag: DisposeBag = DisposeBag()
    let pickerData = ["햄스터", "라쿤", "물고기", "토끼", "새", "원숭이", "개", "고양이"]
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
                                           petImage: petImageView.image,
                                           saveButtonTap: saveButton.rx.tap)
        
        let output = addListVM.transform(input: input)
        
        
        
        output.saveButtonTap
            .withUnretained(self)
            .subscribe { vc, _ in
                // 버튼 클릭 시 데이터 저장메서드.
            }
            .disposed(by: disposeBag)
        
        
    }
}

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
            addListVM?.selectedValue = selectedOption
        }
    
}
