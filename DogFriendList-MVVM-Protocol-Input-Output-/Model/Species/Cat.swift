//
//  Cat.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/1/24.
//

import Foundation

class Cat: Pet {
    func eat() -> String {
        super.eat()
    }
    
    func walkTogether() -> String {
        return "\(name)은 산책을 좋아하지 않습니다."
    }
}

