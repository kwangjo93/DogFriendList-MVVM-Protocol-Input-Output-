//
//  AddListViewModel.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/4/24.
//

import UIKit
import RxSwift
import RxCocoa

class AddListViewModel: ViewModelType {
    struct Input {
        let friendName: ControlProperty<String?>
        let petname: ControlProperty<String?>
        let selectedValue: String?
        let petImage: UIImage?
        let saveButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let selectedValue: String?
        let saveButtonTap: ControlEvent<Void>
    }
    
    var listData: [Person] = []
    private var friendName: String?
    private var petname: String?
    var selectedValue: String?
    var disposeBag: DisposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.friendName
            .asObservable()
            .subscribe(onNext: { [weak self] friendName in
                self?.friendName = friendName
            })
            .disposed(by: disposeBag)

        input.petname
            .asObservable()
            .subscribe(onNext: { [weak self] petname in
                self?.petname = petname
            })
            .disposed(by: disposeBag)
    
        return Output(selectedValue: input.selectedValue,saveButtonTap: input.saveButtonTap)
    }
    
    // MARK: - Method
// selectedValue 값에 따라 이미지의 name을 리턴
// 버튼 클릭 시 데이터를 저장하는 메서드
    
    func getSelecImage() -> UIImage {
        guard let selectedValue else { return UIImage(systemName: "x.circle")! }
        switch selectedValue {
        case "hamster":
            return UIImage(named: "hamster") ?? UIImage(systemName: "x.circle")!
        case "raccoon":
            return UIImage(named: "raccoon") ?? UIImage(systemName: "x.circle")!
        case "fish":
            return UIImage(named: "fish") ?? UIImage(systemName: "x.circle")!
        case "rabbit":
            return UIImage(named: "rabbit") ?? UIImage(systemName: "x.circle")!
        case "bird":
            return UIImage(named: "bird") ?? UIImage(systemName: "x.circle")!
        case "monkey":
            return UIImage(named: "monkey") ?? UIImage(systemName: "x.circle")!
        case "dog":
            return UIImage(named: "dog") ?? UIImage(systemName: "x.circle")!
        case "cat":
            return UIImage(named: "cat") ?? UIImage(systemName: "x.circle")!
        default:
            print("잘못된 문자열")
            return UIImage(systemName: "x.circle")!
        }
    }
    
    func saveListData() {
        
    }
}
