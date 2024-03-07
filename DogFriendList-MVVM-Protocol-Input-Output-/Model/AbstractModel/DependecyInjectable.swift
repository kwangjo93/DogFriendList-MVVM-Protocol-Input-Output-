//
//  DependecyInjectable.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 3/1/24.
//

import Foundation

protocol Animal {
    var name: String { get set}
    func eat() -> String
    func walkTogether() -> String
}
