//
//  DogFriendListViewModel.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DogFriendListViewModel: ViewModelType {
    struct Input {
        let plusButtonTap: ControlEvent<Void>
        let listData: BehaviorSubject<[Person]>
    }
    
    struct Output {
        let plusButtonTap: ControlEvent<Void>
        let listData: BehaviorSubject<[Person]>
    }
    
    func transform(input: Input) -> Output {
        return Output(plusButtonTap: input.plusButtonTap,
                      listData: observableListData)
        
    }

    var disposeBag: DisposeBag = DisposeBag()
    var observableListData: BehaviorSubject<[Person]> = BehaviorSubject(value: [])
}
