//
//  DependecyInjectable.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/1/24.
//

import Foundation

protocol Animal {
    var name: String { get set}
}

extension Animal {
    func eat() -> String {
        return "\(name) 이 사료를 먹습니다."
    }
    
    func walkTogether() -> String {
        return "\(name)이 함께 걷는 것을 좋아합니다."
    }
}
