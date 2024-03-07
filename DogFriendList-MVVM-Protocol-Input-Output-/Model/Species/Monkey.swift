//
//  Monkey.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/1/24.
//

import Foundation

class Monkey: Pet {
    override func eat() -> String {
        return "\(name)은 바나나를 좋아합니다."
    }
    
    override func walkTogether() -> String {
        super.walkTogether()
    }
}
