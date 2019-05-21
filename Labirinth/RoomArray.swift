//
//  RoomArray.swift
//  класс для хранения массива классов LabirinthRoom и представления данных в виде двумерного массива
//
//  Created by User on 11/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

class RoomArray {
    private var cols: Int, rows: Int
    var colCount: Int {
        get {
            return cols
        }
    }
    var rowCount: Int {
        get {
            return rows
        }
    }
    var matrix = [LabirinthRoom]()
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        for x in 0...rows - 1 {
            for y in 0...cols - 1 {
                matrix.append(LabirinthRoom(coordinates: (x, y), doors: (false, false, false, false)))
            }
        }
    }
    
    subscript(x: Int, y: Int) -> LabirinthRoom? {
        get{
            if x < 0 || x > rows - 1 || y < 0 || y > cols - 1 {
                return nil
            }
            
            return matrix[matrix.count/rows * x + y]
        }
    }
    
    func destroyData() {
        matrix.removeAll()
    }
    
    func randomElement() -> LabirinthRoom? {
        return matrix.randomElement()
    }
}
