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
        let listData: Observable<[Person]>?
    }
    
    struct Output {
        let listData: Observable<[Person]>?
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        return Output(listData: input.listData)
       }
}
