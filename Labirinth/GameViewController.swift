//
//  GameViewController.swift
//  класс - представление-контроллер игры
//
//  Created by User on 14/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    @IBOutlet var objectPlaces: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Запрашиваем первую случайную комнату
        guard let labirinthRoom = LabirinthModel.delegate?.getRandomRoomData() else {
            print("No Room")
            return
        }
        LabirinthModel.delegate?.setCurrentRoom(room: labirinthRoom)
        setVisuals(room: labirinthRoom)
    }
    
    @IBAction func onLeft(_ sender: Any) {
        guard let labirinthRoom = LabirinthModel.delegate?.getRoomData(direction: .left) else {
            print(LabirinthModel.delegate?.currentRoom?.getDoors ?? "current room = nil")
            return
        }
        LabirinthModel.delegate?.setCurrentRoom(room: labirinthRoom)
        setVisuals(room: labirinthRoom)
    }
    @IBAction func onRight(_ sender: Any) {
        guard let labirinthRoom = LabirinthModel.delegate?.getRoomData(direction: .right) else {
            print(LabirinthModel.delegate?.currentRoom?.getDoors ?? "current room = nil")
            return
        }
        LabirinthModel.delegate?.setCurrentRoom(room: labirinthRoom)
        setVisuals(room: labirinthRoom)
    }
    @IBAction func onTop(_ sender: Any) {
        guard let labirinthRoom = LabirinthModel.delegate?.getRoomData(direction: .top) else {
            print(LabirinthModel.delegate?.currentRoom?.getDoors ?? "current room = nil")
            return
        }
        LabirinthModel.delegate?.setCurrentRoom(room: labirinthRoom)
        setVisuals(room: labirinthRoom)
    }
    @IBAction func onBottom(_ sender: Any) {
        guard let labirinthRoom = LabirinthModel.delegate?.getRoomData(direction: .bottom) else {
            print(LabirinthModel.delegate?.currentRoom?.getDoors ?? "current room = nil")
            return
        }
        LabirinthModel.delegate?.setCurrentRoom(room: labirinthRoom)
        setVisuals(room: labirinthRoom)
    }
    
    @IBAction func onExitClick(_ sender: Any) {
    LabirinthModel.delegate?.destroyLabirinth()
        self.dismiss(animated: true, completion: nil)
    }
    
    // Выставление изображений и кнопок на view в зависимости от данных модели
    private func setVisuals(room: LabirinthRoom) {
        setButtonsVisible(isVisible: room.getDoors)
        
        for i in 0...objectPlaces.count - 1 {
            if i < room.allObjects.count {
                objectPlaces[i].isEnabled = true
                objectPlaces[i].setImage(room.allObjects[i].image, for: .normal)
                objectPlaces[i].alpha = 1
            } else {
                objectPlaces[i].alpha = 0
                objectPlaces[i].isEnabled = false
            }
        }
    }
    
    // Выставление видимости кнопок в зависимости от имеющихся выходов в комнате модели
    private func setButtonsVisible(isVisible: (right: Bool, left: Bool, top: Bool, bottom: Bool)?) {
        // isHidden не работает!
        leftButton.isEnabled = isVisible?.left ?? false
        if leftButton.isEnabled {
            leftButton.alpha = 1
        } else {
            leftButton.alpha = 0
        }
        rightButton.isEnabled = isVisible?.right ?? false
        if rightButton.isEnabled {
            rightButton.alpha = 1
        } else {
            rightButton.alpha = 0
        }
        topButton.isEnabled = isVisible?.top ?? false
        if topButton.isEnabled {
            topButton.alpha = 1
        } else {
            topButton.alpha = 0
        }
        bottomButton.isEnabled = isVisible?.bottom ?? false
        if bottomButton.isEnabled {
            bottomButton.alpha = 1
        } else {
            bottomButton.alpha = 0
        }
    }
}
