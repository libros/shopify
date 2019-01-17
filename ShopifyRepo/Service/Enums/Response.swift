//
//  Router.swift
//  ShopifyRepo
//
//  Created by Joel Meng on 1/16/19.
//  Copyright © 2019 Joel Meng. All rights reserved.
//

import Foundation

enum Response<T> {
    case success(T)
    case failure(Error)
}
