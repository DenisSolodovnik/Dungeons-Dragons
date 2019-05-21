//
//  LabirinthModel.swift
//  класс-модель лабиринта, реализующий протокол основных данных и функций класса, предоставляя
//  их через статический публичный singleton
//
//  Created by User on 10/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

enum DoorDirections {
    case left
    case right
    case top
    case bottom
}
public enum ObjectTypes: CaseIterable {
    case key
    case box
    case stone
    case mushroom
    case bone
    case food
    case torch
}

protocol LabirinthProtocol: class {
    var currentRoom: LabirinthRoom? { get }
    func CreateLabirinth(width: Int, height: Int)
    func destroyLabirinth()
    func getRoomData(xPos: Int, yPos: Int) -> LabirinthRoom?
    func getRoomData(direction: DoorDirections) -> LabirinthRoom?
    func getRandomRoomData() -> LabirinthRoom?
    func setCurrentRoom(room: LabirinthRoom?)
}

class LabirinthModel: NSObject {
    static var delegate: LabirinthProtocol? = LabirinthModel()
    
    var currentRoom: LabirinthRoom?
    
    var labirinthSize: (x: Int, y: Int) = (x: 0, y: 0)

    private var allRooms: RoomArray?
    
    private var isLabiritCreated = false
    
    private override init() {
        super.init()
        allRooms = nil
    }
}

extension LabirinthModel: LabirinthProtocol {
    // Создание лабиринта
    func CreateLabirinth(width: Int, height: Int) {
        if isLabiritCreated {
            destroyLabirinth()
        }
        
        labirinthSize = (width, height)
        allRooms = RoomArray.init(rows: width, cols: height)

        for x in 0...labirinthSize.x - 1 {
            for y in 0...labirinthSize.y - 1 {
                allRooms?[(labirinthSize.x - 1) - x, y]?.setDoors(doors: getDoors(x: (labirinthSize.x - 1) - x, y: y))
                allRooms?[(labirinthSize.x - 1) - x, y]?.addObjects(roomObjects: getObjects())
            }
        }
        
        if let room = LabirinthModel.delegate?.getRandomRoomData() {
            room.addObject(roomObject: RoomObject(objectType: .key))
        }
        
        if let room = LabirinthModel.delegate?.getRandomRoomData() {
            room.addObject(roomObject: RoomObject(objectType: .box))
        }
        
        isLabiritCreated = true
    }
    
    // Уничтожение лабиринта
    func destroyLabirinth() {
        labirinthSize = (0, 0)
        allRooms?.destroyData()
        
        isLabiritCreated = false
    }
    
    // Получение комнаты по: координатам, направлению от предыдущей
    func getRoomData(xPos: Int, yPos: Int) -> LabirinthRoom? {
        return allRooms?[xPos, yPos]
    }
    func getRoomData(direction: DoorDirections) -> LabirinthRoom? {
        guard let coordinates = currentRoom?.coordinates else {
            print("no coordinates")
            return nil
        }
        
        var room: LabirinthRoom?
        
        switch direction {
        case .left:
            room = getRoomData(xPos: coordinates.x, yPos: coordinates.y - 1)
        case .right:
            room = getRoomData(xPos: coordinates.x, yPos: coordinates.y + 1)
        case .top:
            room = getRoomData(xPos: coordinates.x - 1, yPos: coordinates.y)
        case .bottom:
            room = getRoomData(xPos: coordinates.x + 1, yPos: coordinates.y)
        }
        
        return room
    }
    
    // Получение случайной комнаты
    func getRandomRoomData() -> LabirinthRoom? {
        return allRooms?.randomElement()
    }
    
    // Установка текущей комнаты
    func setCurrentRoom(room: LabirinthRoom?) {
        currentRoom = room
    }
}

extension LabirinthModel {
    // Создает массив объектов для комнаты
    func getObjects() -> [RoomObject] {
        let count = Int.random(in: 0...1)
        var tmpObjects = [RoomObject]()
        var object: ObjectTypes?
        
        for _ in 0...count {
            repeat {
                object = ObjectTypes.allCases.randomElement()
            } while object == .key || object == .box
            tmpObjects.append(RoomObject(objectType: object ?? .bone))
        }
        return tmpObjects
    }
}

extension LabirinthModel {
    // Создает двери для комнаты
    func getDoors(x: Int, y: Int) -> (Bool, Bool, Bool, Bool) {
        let rightDoor: Bool
        let topDoor: Bool
        var leftDoor = false
        var bottomDoor = false
        
        var room: LabirinthRoom?
        var room2: LabirinthRoom?
        
        room = allRooms?[x, y - 1]
        if room != nil {
            leftDoor = (room?.getDoors.right)!
        } else {
            leftDoor = false
        }
        
        room = allRooms?[x + 1, y]
        if room != nil {
            bottomDoor = (room?.getDoors.top)!
        } else {
            bottomDoor = false
        }
        
        room = allRooms?[x - 1, y]
        room2 = allRooms?[x, y + 1]
        
        if room != nil && room2 != nil {
            rightDoor = Bool.random()
            topDoor = !rightDoor
        } else if room != nil && room2 == nil {
            rightDoor = false
            topDoor = true
        } else if room == nil && room2 != nil {
            rightDoor = true
            topDoor = false
        } else {
            rightDoor = false
            topDoor = false
        }
        
        return (leftDoor, rightDoor, topDoor, bottomDoor)
    }
}
