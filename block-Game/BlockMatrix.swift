//
//  BlockMatrix.swift
//  block-Game
//
//  Created by Vikram Kumar on 14/03/26.
//

import Foundation

protocol Block {
    
    associatedtype Value
    
    var number: Value { get set }
    
}

struct IndexedBlock<T> {
    
    let index: (Int, Int)
    let item: T?

}

struct BlockMatrix<T> : CustomDebugStringConvertible where T: Block {
    
    typealias Index = (Int, Int)
    
    fileprivate var matrix: [[T?]]
    
    init() {
        matrix = [[T?]]()
        for _ in 0..<4 {
            var row = [T?]()
            for _ in 0..<4 {
                row.append(nil)
            }
            matrix.append(row)
        }
    }
