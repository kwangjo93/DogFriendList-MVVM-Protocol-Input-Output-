//
//  DogFriendListViewModel.swift
//  DogFriendList-MVVM-Protocol-Input-Output-
//
//  Created by 천광조 on 2/29/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class DogFriendListViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
    
            return Output()
       }

    private func goToNextVC(storyBoard: UIStoryboard?, fromCurrentVC: UIViewController, animated: Bool) {
        guard let secondVC = storyBoard?
            .instantiateViewController(identifier: "AddListViewController", creator: { coder in
                AddListViewController() })
        else {
            fatalError("SecondViewController 생성 에러")
        }
        
        secondVC.modalPresentationStyle = .fullScreen
        fromCurrentVC.present(secondVC, animated: true, completion: nil)
    }
}
