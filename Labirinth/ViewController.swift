//
//  ViewController.swift
//  класс - контроллер-представление стартовой сцены игры
//
//  Created by User on 09/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

// расширение для преобразование строки в число
extension Optional where Wrapped == String {
    var digit: Int {
        return Int(self ?? "1") ?? 1
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var xSizeText: UITextField!
    @IBOutlet weak var ySizeText: UITextField!
    @IBOutlet weak var startGameButton: UIButton!
    
    override func viewDidLoad() {
        startGameButton.isEnabled = false;
        super.viewDidLoad()
    }

    @IBAction func createLabirinth(_ sender: Any) {
        view.endEditing(true)
        
        // Если данные не введены в текстовые поля или введены нули - лабиринт не создастся
        if xSizeText.text?.isEmpty ?? true || xSizeText.text.digit == 0 || ySizeText.text?.isEmpty ?? true || ySizeText.text.digit == 0 {
            startGameButton.isEnabled = false;
            return
        }
        
        LabirinthModel.delegate?.CreateLabirinth(width: xSizeText.text.digit, height: ySizeText.text.digit)
        
        startGameButton.isEnabled = true
    }
}

