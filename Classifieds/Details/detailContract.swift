//
//  detailContract.swift
//  Classifieds
//
//  Created by kamran on 09/02/2021.
//

import UIKit

protocol detailViewType: class {
    
    var presenter: detailPresenterType? { get set }
    
}

protocol detailPresenterType: class {
    
    func viewDidLoad()
 
}
