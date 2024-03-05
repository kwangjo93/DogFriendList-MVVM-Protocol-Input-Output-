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
}
