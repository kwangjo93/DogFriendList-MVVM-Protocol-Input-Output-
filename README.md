# DogFriendList-MVVM-Protocol-Input-Output-

## MVVM - Protocol Input Output 의 디자인 패턴 + 객체지향의 특징을 살린 간단한 앱
<img src="https://github.com/kwangjo93/DogFriendList-MVVM-Protocol-Input-Output-/assets/125628009/1b5d1065-bd14-4b5b-a48e-06a602c51ca1" alt="Simulator Screenshot - iPhone 15 Pro - 2024-02-27 at 15 12 10" width="250" height="500">
<img src="https://github.com/kwangjo93/DogFriendList-MVVM-Protocol-Input-Output-/assets/125628009/c06f2764-d6b2-4838-8f9e-556731aab6c4" alt="Simulator Screenshot - iPhone 15 Pro - 2024-02-27 at 15 12 10" width="250" height="500">
<img src="https://github.com/kwangjo93/DogFriendList-MVVM-Protocol-Input-Output-/assets/125628009/14b7c763-2774-4648-9d80-a415379ca743" alt="Simulator Screenshot - iPhone 15 Pro - 2024-02-27 at 15 12 10" width="250" height="500">

## 1. MVVM - Protocol Input Output
- 한 단계 더 발전된 MVVM 디자인 패턴
- 더 좋은 유지보수를 위해 Protocol Input Output 채택
    - Input Output 으로만 데이터를 받고 처리하기 때문에 데이터 또는 로직 변경 외 에러에도 빠르게 대응이 가능하다.

![C8E2319F-6D45-4AB3-8968-BCC85731A607](https://github.com/kwangjo93/DogFriendList-MVVM-Protocol-Input-Output-/assets/125628009/5fc7648a-a46c-4ffc-b3d9-6a83af65fb5d)

#### — 멤버 설명
- **Model**
    - 데이터와 비즈니스 로직을 담당한다.
    - 앱의 상태와 데이터를 정의하고 관리한다.
- **View**
    - 사용자에게 보이는 화면을 나타낸다.
    - View 의 Action 을 ViewModel 로 전달한다. → Input
    - 비즈니스 로직이 없어야 한다.
- **ViewModel**
    - View와 Model 간의 중개자 역할을 한다.
    - View에 표시될 데이터를 가공하고 제공한다.  → Output
    - 사용자 입력을 처리하고, 이벤트를 View나 Model로 전달한다.
    - View에 대한 참조를 가지지 않으며, 어떤 View에서든 사용될 수 있다.

#### — 작성 방법
- View 의 Action 을 Input을 통해 ViewModel 로 보낸다.
- ViewModel 에서는 Input으로부터 Action을 받아 처리하는 로직을 만든다.
- Model 데이터를 가공 처리하여 Output을 통해 다시 View로 데이터를 보낸다.
- View에서는 가공된 데이터 Output을 이용하여 ViewModel 의 로직을 사용하여 처리하고 View를 업데이트 한다.

#### — 코드 예시
```swift
* 어떤 ViewModel 에서도 적용할 수 있도록 Protocol 정의
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}

* ViewModel 정의 (VM -> VC Output 전달)
final class DogFriendListViewModel: ViewModelType {
    struct Input { //VC 에서 받을 값
        let plusButtonTap: ControlEvent<Void>
        let listData: BehaviorSubject<[Person]>
    }
    
    struct Output {
        let plusButtonTap: ControlEvent<Void>
        let listData: BehaviorSubject<[Person]>
    }
    
    func transform(input: Input) -> Output {
    //Vc 로 보낼 값
        return Output(plusButtonTap: input.plusButtonTap,
                      listData: observableListData)
        
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    var observableListData: BehaviorSubject<[Person]> = BehaviorSubject(value: [])
}

* ViewController - (VC -> VM Input 전달)
@IBOutlet weak var petListTableView: UITableView!
    @IBOutlet weak var eatLabel: UILabel!
    @IBOutlet weak var walkLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    var disposeBag: DisposeBag = DisposeBag()
    let dogFriendListVM = DogFriendListViewModel()
    lazy var addListVM = AddListViewModel(observableListData: dogFriendListVM.observableListData)
    
=
private func bindViewModel() {
//ex, tab의 action을 전달
	let input = DogFriendListViewModel.Input(plusButtonTap: plusButton.rx.tap,
                                   listData: dogFriendListVM.observableListData)
  let output = dogFriendListVM.transform(input: input)
        
        //output으로 전달 받은 데이터로 로직 처리.
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
```

#### — 장 단점
- 장점
    - View를 통해 모든 데이터를 Input을 통해 ViewModel 로 보내므로 직관적이다.
    - View 로 다시 Output을 보내 데이터를 처리 하므로 모든 유지보수를 Input, output으로 처리할 수 있어서 편리하다.
- 단점
    - RXSwift 등 반응형 프로그래밍에 대한 이해가 필요하다는 점, 러닝 커브가 높다.





## 2. 객체지향의 특징

#### 1) 캡슐화(Encapsulation): 관련된 데이터와 메소드를 하나의 단위로 묶어 외부에서의 접근을 제한하는 것을 의미합니다. 이는 데이터를 보호하고 은닉함으로써 시스템의 안정성과 보안을 높입니다.
    ```swift
    * 데이터를 저장하는 뷰의 뷰모델에서 저정되는 변수는 private 으로 은닉화를 해서 다른 곳에서 접근을 막고 데이터의 안전을 지킨다.
    class AddListViewModel: ViewModelType {
    
    private var listData: [Person] = []   // <- 캡슐화
    
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
    }
    ```
#### 2) 상속(Inheritance): 이미 존재하는 클래스의 특성을 다른 클래스가 상속받아 확장하거나 재정의할 수 있는 기능입니다. 이를 통해 코드의 재사용성을 높이고 구조를 계층화하여 관리하기 용이합니다.
```swift
* 상속을 통해 메서드를 그대로 사용할 수 있고, 또는 변경할 수도 있다.
class Pet {
    var name: String
    var species: Species
    
    init(name: String, species: Species) {
        self.name = name
        self.species = species
    }

    func eat() -> String {
        return "\(name) 이 사료를 먹습니다."
    }
    
    func walkTogether() -> String {
        return "\(name)이 함께 걷는 것을 좋아합니다."
    }
}

class Hamster: Pet {
    override func eat() -> String {
        super.eat()
    }
    
    override func walkTogether() -> String {
        return "\(name)은 주인과 함께 산책하지 않습니다."
    }
}
```
#### 3) 다형성(Polymorphism): 같은 이름의 메소드나 함수를 호출할 때, 실제로 호출되는 구현이 다를 수 있는 기능을 의미합니다. 이는 코드의 유연성을 높이고 동적인 동작을 가능하게 합니다.
```swift
protocol Animal {
    var name: String { get set}
    func eat() -> String
    func walkTogether() -> String
}

class Pet: Animal {
    var name: String
    var species: Species
    
    init(name: String, species: Species) {
        self.name = name
        self.species = species
    }

    func eat() -> String {
        return "\(name) 이 사료를 먹습니다."
    }
    
    func walkTogether() -> String {
        return "\(name)이 함께 걷는 것을 좋아합니다."
    }
}
** Animal 이라는 공통적이면서 추상적은 개념을 Pet과 Person이 상속을 한다.
그리고 Person 안에는 Animal 이라는 타입의 pet 변수가 있다.
class Person: Animal {
    var name: String
    var pet: [Animal]
    init(name: String, pet: [Animal]) {
        self.name = name
        self.pet = pet
    }
 
    func eat() -> String {
        return "\(name)은 사료를 먹지 않고, 음식을 먹습니다."
    }
    
    func walkTogether() -> String {
        return  "\(name)은 함께 걷는 것을 좋아합니다."
    }
    
}

---
* Animal 을 상속한 Pet을 또 상속한 구체적인 동물을 만든다.
class Hamster: Pet {
    override func eat() -> String {
        super.eat()
    }
    
    override func walkTogether() -> String {
        return "\(name)은 주인과 함께 산책하지 않습니다."
    }
}
class Raccoon: Pet {
    override func eat() -> String {
        super.eat()
    }
    
    override func walkTogether() -> String {
        super.walkTogether()
    }
}

----
* 동일한 동작을 하는 공통체 이지만 각각의 구체적인 행동들이 정의되어 있고, 집합체에는 공통의 성격을 지닌 타입으로 정의할 수 있다.
let hamster = Hamster()
let raccon = Raccoon()
var pet: [Animal] = [hamster, raccon]
```

#### 4) 추상화(Abstraction): 복잡한 시스템에서 중요한 부분만을 간추려 내어 모델링하는 것을 의미합니다. 이를 통해 개발자는 핵심적인 기능에 집중할 수 있고, 코드의 이해와 관리가 용이해집니다.
```swift
* Animal 에서는 공통의 변수 또는 메서드 설정
* Animal을 상속한 객체는 구체적인 클래스 이므로 구체적인 데이터를 정의한다.

class Person: Animal {
    var name: String
    var pet: [Animal]
    init(name: String, pet: [Animal]) {
        self.name = name
        self.pet = pet
    }
 
    func eat() -> String {
        return "\(name)은 사료를 먹지 않고, 음식을 먹습니다."
    }
    
    func walkTogether() -> String {
        return  "\(name)은 함께 걷는 것을 좋아합니다."
    }
    
}

class Pet: Animal {
    var name: String
    var species: Species
    
    init(name: String, species: Species) {
        self.name = name
        self.species = species
    }

    func eat() -> String {
        return "\(name) 이 사료를 먹습니다."
    }
    
    func walkTogether() -> String {
        return "\(name)이 함께 걷는 것을 좋아합니다."
    }
}

```
