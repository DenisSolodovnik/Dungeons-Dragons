//
//  RoomObject.swift
//  Класс-идентификатор вещи в комнате
//  не до конца разобрался с наследованием в C# я бысоздал класс вещь и унаследовал от него классы ключ, сундук и т.д.
//
//  Created by User on 11/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit

class RoomObject {    
    let objectType: ObjectTypes
    
    let image: UIImage // Картинка объекта
    
    let canEat: Bool
    let canUse: Bool
    let canDrop: Bool
    let canTake: Bool
    
    init(objectType: ObjectTypes) {
        self.objectType = objectType
        
        switch objectType {
        case .key:
            canEat = false
            canUse = true
            canDrop = false
            canTake = true
            image = #imageLiteral(resourceName: "key")
        case .box:
            canEat = false
            canUse = false
            canDrop = false
            canTake = false
            image = #imageLiteral(resourceName: "chest")
        case .stone:
            canEat = false
            canUse = false
            canDrop = true
            canTake = true
            image = #imageLiteral(resourceName: "stone")
        case .mushroom:
            canEat = false
            canUse = false
            canDrop = true
            canTake = true
            image = #imageLiteral(resourceName: "mushroom")
        case .bone:
            canEat = false
            canUse = false
            canDrop = true
            canTake = true
            image = #imageLiteral(resourceName: "bone")
        case .food:
            canEat = true
            canUse = false
            canDrop = true
            canTake = true
            image = #imageLiteral(resourceName: "apple")
        case .torch:
            canEat = false
            canUse = true
            canDrop = true
            canTake = true
            image = #imageLiteral(resourceName: "torch")
        }
    }
}
