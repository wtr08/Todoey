//
//  Item.swift
//  Todoey
//
//  Created by Wouter van Rijmenam on 14/03/2018.
//  Copyright © 2018 Stackmont. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?

    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
