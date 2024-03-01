//
//  Person.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/1/24.
//

import Foundation

class Person: Animal {
    var name: String
    var pet: [Pet]
    
    init(name: String, pet: [Pet]) {
        self.name = name
        self.pet = pet
    }
 
    func eat(index: Int) -> String {
        return "\(name)은 \(pet[index].name)의 사료를 먹지 않고, 음식을 먹습니다."
    }
    
    func walkTogether(index: Int) -> String {
        return  "\(name)은 \(pet[index].name)과 함께 걷는 것을 좋아합니다."
    }
    
}
