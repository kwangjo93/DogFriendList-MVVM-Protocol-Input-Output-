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
        let selectedValue: Observable<String?>
        let saveButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let selectedValue: Observable<String?>
        let saveButtonTap: ControlEvent<Void>
    }
    
    var listData: [Person] = []
    private var friendName: String?
    private var petname: String?
    var selectedValue = BehaviorSubject<String?>(value: nil)
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
    
        return Output(selectedValue: selectedValue, saveButtonTap: input.saveButtonTap)
    }
    
    // MARK: - Method
// selectedValue 값에 따라 이미지의 name을 리턴
// 버튼 클릭 시 데이터를 저장하는 메서드
    
    func getSelectedImage(selectedValue: String) -> UIImage? {
        switch selectedValue {
        case "햄스터":
            return UIImage(named: "hamster")
        case "라쿤":
            return UIImage(named: "raccoon")
        case "물고기":
            return UIImage(named: "fish")
        case "토끼":
            return UIImage(named: "rabbit")
        case "새":
            return UIImage(named: "bird")
        case "원숭이":
            return UIImage(named: "monkey")
        case "개":
            return UIImage(named: "dog")
        case "고양이":
            return UIImage(named: "cat")
        default:
            print("잘못된 문자열")
            return nil
        }
    }
    
    func saveListData() {
        let pet = Pet(name: petname ?? "", species: getSpeciesData())
        guard let petData = defineSpeciesFromPet(pet) else { return }
        switch checkDuplicationData() {
        case true:
            if let index = listData.firstIndex(where: { $0.name == friendName }) {
                listData[index].pet.insert(petData, at: 0)
            } else {
                break
            }
        case false:
            let person = Person(name: friendName ?? "", pet: [petData])
            listData.append(person)
        }
    }
    
    private func checkDuplicationData() -> Bool {
        if listData.contains(where: { $0.name == friendName}) {
            return true
        } else {
            return false
        }
    }

    private func getSpeciesData() -> Species {
        var species: Species = .dog
        _ = selectedValue.subscribe(onNext: { value in
            let selectedValue = value
            switch selectedValue {
            case "햄스터":
                species = .hamster
            case "라쿤":
                species = .raccoon
            case "물고기":
                species = .fish
            case "토끼":
                species = .rabbit
            case "새":
                species = .bird
            case "원숭이":
                species = .monkey
            case "개":
                species = .dog
            case "고양이":
                species = .cat
            default:
                species = .dog
            }
        })
        return species
    }

    private func defineSpeciesFromPet(_ pet: Pet) -> Pet? {
        var pet: Pet?
        _ = selectedValue.subscribe(onNext: { value in
            let selectedValue = value
            switch selectedValue {
            case "햄스터":
                pet = pet as? Hamster
            case "라쿤":
                pet = pet as? Raccoon
            case "물고기":
                pet = pet as? Fish
            case "토끼":
                pet = pet as? Rabbit
            case "새":
                pet = pet as? Bird
            case "원숭이":
                pet = pet as? Monkey
            case "개":
                pet = pet as? Dog
            case "고양이":
                pet = pet as? Cat
            default:
                pet = pet as? Dog
            }
        })
        return pet
    }

}
