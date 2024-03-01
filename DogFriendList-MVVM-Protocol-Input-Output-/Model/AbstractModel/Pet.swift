//
//  Pet.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import Foundation

class Pet: Animal {
    var name: String
    var species: species
    
    init(name: String, species: species) {
        self.name = name
        self.species = species
    }
}
