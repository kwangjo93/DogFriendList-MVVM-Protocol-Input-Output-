//
//  Rabbit.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/1/24.
//

import Foundation

class Rabbit: Pet {
    override func eat() -> String {
        return "\(name)은 당근을 좋아합니다"
    }
    
    override func walkTogether() -> String {
        return "\(name)은 주인과 함께 산책하지 않습니다."
    }
}
