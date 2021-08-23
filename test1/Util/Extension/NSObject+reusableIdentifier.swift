//
//  NSObject+reusableIdentifier.swift
//  test1
//
//  Created by 장진혁 on 2021/08/22.
//

import UIKit

extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
