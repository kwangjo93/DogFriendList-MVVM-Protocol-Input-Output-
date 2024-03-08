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
        let backBUttonTap: ControlEvent<Void>
    }
    
    struct Output {
        let selectedValue: Observable<String?>
        let saveButtonTap: ControlEvent<Void>
        let backBUttonTap: ControlEvent<Void>
    }
    
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
        
        return Output(selectedValue: selectedValue,
                      saveButtonTap: input.saveButtonTap,
                      backBUttonTap: input.backBUttonTap)
    }
    
    private var listData: [Person] = []
    var selectedValue = BehaviorSubject<String?>(value: nil)
    var disposeBag: DisposeBag = DisposeBag()
    var observableListData: BehaviorSubject<[Person]>
    private var friendName: String?
    private var petname: String?
    
    init(observableListData: BehaviorSubject<[Person]>) {
        self.observableListData = observableListData
    }
    // MARK: - Method
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
    
    func saveListData(view:UIViewController) {
        let pet = Pet(name: petname ?? "", species: getSpeciesData())
        let specificPet = defineSpeciesFromPet(pet)
        switch checkDuplicationData() {
        case true:
            if let index = listData.firstIndex(where: { $0.name == friendName }) {
                listData[index].pet.insert(specificPet, at: 0)
            } else {
                break
            }
        case false:
            let person = Person(name: friendName ?? "", pet: [specificPet])
            listData.append(person)
        }
        observableListData.onNext(listData)
        backToPreviousView(view: view)
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
    
    private func defineSpeciesFromPet(_ pet: Pet) -> Animal {
        var petCopy = pet
        _ = selectedValue.subscribe(onNext: { value in
            let selectedValue = value
            switch selectedValue {
            case "햄스터":
                petCopy = Hamster(name: pet.name, species: pet.species)
            case "라쿤":
                petCopy = Raccoon(name: pet.name, species: pet.species)
            case "물고기":
                petCopy = Fish(name: pet.name, species: pet.species)
            case "토끼":
                petCopy = Rabbit(name: pet.name, species: pet.species)
            case "새":
                petCopy = Bird(name: pet.name, species: pet.species)
            case "원숭이":
                petCopy = Monkey(name: pet.name, species: pet.species)
            case "개":
                petCopy = Dog(name: pet.name, species: pet.species)
            case "고양이":
                petCopy = Cat(name: pet.name, species: pet.species)
            default:
                petCopy = Dog(name: pet.name, species: pet.species)
            }
        })
        return petCopy
    }
    
    func backToPreviousView(view:UIViewController) {
        view.dismiss(animated: true)
    }
}
