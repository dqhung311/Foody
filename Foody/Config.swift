//
//  Config.swift
//  Foody
//
//  Created by Dao Quang Hung on 5/30/17.
//  Copyright © 2017 Dao Quang Hung. All rights reserved.
//

import Foundation
import UIKit

class Config{
    let tabProduct: String = "Product"
    let tabCategory: String = "Category"
    let tabProvince: String = "Province"
    let tabMyCollection: String = "MyCollection"
    let tabLatestCollection: String = "LatestCollection"
    init(){

    }
    func getTabProduct() -> String {
        return tabProduct
    }
    func getTabCategory() -> String {
        return tabCategory
    }
    func getTabProvince() -> String {
        return tabProvince
    }
    func getTabMyCollection() -> String {
        return tabMyCollection
    }
    func getTabLatestCollection() -> String {
        return tabLatestCollection
    }
}


