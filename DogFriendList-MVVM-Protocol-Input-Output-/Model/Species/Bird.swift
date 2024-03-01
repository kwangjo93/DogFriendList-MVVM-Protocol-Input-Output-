//
//  Bird.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/1/24.
//

import Foundation

class Bird: Pet {
    func eat() -> String {
        super.eat()
    }
    
    func walkTogether() -> String {
        return "\(name)은 주인과 함께 산책하지 않습니다."
    }
}
