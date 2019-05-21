//
//  LabirinthRoom.swift
//  класс LabirinthRoom, хранящий в себе данные о выходах из комнаты, и хранящихся в ней вещах
//
//  Created by User on 10/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class LabirinthRoom {
    private var doors: (left: Bool, right: Bool, top: Bool, bottom: Bool)
    var getDoors: (left: Bool, right: Bool, top: Bool, bottom: Bool) {
        get {
            return doors
        }
    }
    
    private var objects = [RoomObject]()
    var allObjects: [RoomObject] {
        get {
            return objects
        }
    }
    
    let coordinates: (x: Int, y: Int)
    
    init(coordinates: (x: Int, y: Int), doors: (left: Bool, right: Bool, top: Bool, bottom: Bool)) {
        self.doors = doors
        self.coordinates = coordinates
    }
    
    func setDoors(doors: (left: Bool, right: Bool, top: Bool, bottom: Bool)) {
        self.doors = doors
    }
    
    // Добавить объекты/объект в комнату
    func addObjects(roomObjects: [RoomObject]) {
        objects += roomObjects
    }
    func addObject(roomObject: RoomObject) {
        objects.append(roomObject)
    }
    
    // Получить объект из комнаты с удалением из комнаты
    func getObject(roomObject: RoomObject) -> RoomObject? {
        let idx = objects.lastIndex(where: {roomObject.objectType == $0.objectType})
        
        guard let index = idx else {
            return nil
        }
        
        let obj = objects[index]
        objects.remove(at: index)
        
        return obj
    }
}
