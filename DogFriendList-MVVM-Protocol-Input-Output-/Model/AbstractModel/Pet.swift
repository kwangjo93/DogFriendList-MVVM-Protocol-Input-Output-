//
//  Pet.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import Foundation

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
