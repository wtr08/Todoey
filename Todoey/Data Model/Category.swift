//
//  Category.swift
//  Todoey
//
//  Created by Wouter van Rijmenam on 14/03/2018.
//  Copyright © 2018 Stackmont. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    // List is from Realm.io framework
    let items = List<Item>()
    
    
}
