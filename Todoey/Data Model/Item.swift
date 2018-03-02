//
//  Item.swift
//  Todoey
//
//  Created by Wouter van Rijmenam on 26/02/2018.
//  Copyright © 2018 Stackmont. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    
    var title: String = ""
    var done: Bool = false
    

}
