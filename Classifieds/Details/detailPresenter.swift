//
//  detailPresenter.swift
//  Classifieds
//
//  Created by kamran on 09/02/2021.
//

import UIKit
import SDWebImage

class detailPresenter: NSObject {
    
    private weak var view: detailViewType?
    
    required init(view: detailViewType) {
        self.view = view
        
    }
    
}

extension detailPresenter: detailPresenterType {
    
    func viewDidLoad() {
    }
   
}
