//
//  BlockMatrix.swift
//  block-Game
//
//  Created by Vikram Kumar on 14/03/26.
//
import Foundation

// MARK: - Block Protocol

protocol Block {
    associatedtype Value
    var number: Value { get set }
}

// MARK: - IndexedBlock

struct IndexedBlock<T> {
    let index: (Int, Int)
    let item: T?
}

// MARK: - BlockMatrix

struct BlockMatrix<T>: CustomDebugStringConvertible where T: Block {
    
    typealias Index = (Int, Int)
    
    private(set) var size: Int
    fileprivate var matrix: [[T?]]
    
    // MARK: - Init (Dynamic Size)
    
    init(size: Int = 4) {
        self.size = size
        self.matrix = Array(
            repeating: Array(repeating: nil, count: size),
            count: size
        )
    }
    
    // MARK: - Debug
    
    var debugDescription: String {
        matrix.map { row in
            row.map {
                if let value = $0 {
                    return "\(value.number)"
                } else {
                    return "."
                }
            }
            .joined(separator: "\t")
        }
        .joined(separator: "\n")
    }
    
    // MARK: - Flatten
    
    var flatten: [IndexedBlock<T>] {
        matrix.enumerated().flatMap { (y, row) in
            row.enumerated().map { (x, item) in
                IndexedBlock(index: (x, y), item: item)
            }
        }
    }
    
    // MARK: - Subscript (Safe Read/Write)
    
    subscript(index: Index) -> T? {
        get {
            guard isIndexValid(index) else { return nil }
            return matrix[index.1][index.0]
        }
        set {
            guard isIndexValid(index) else { return }
            matrix[index.1][index.0] = newValue
        }
    }
    
    // MARK: - Move
    
    mutating func move(from: Index, to: Index) {
        guard isIndexValid(from), isIndexValid(to),
              let source = self[from] else { return }
        
        matrix[to.1][to.0] = source
        matrix[from.1][from.0] = nil
    }
    
    mutating func move(from: Index, to: Index, with newValue: T.Value) {
        guard isIndexValid(from), isIndexValid(to),
              var source = self[from] else { return }
        
        source.number = newValue
        matrix[to.1][to.0] = source
        matrix[from.1][from.0] = nil
    }
    
    // MARK: - Place
    
    mutating func place(_ block: T?, to index: Index) {
        guard isIndexValid(index) else { return }
        matrix[index.1][index.0] = block
    }
    
    // MARK: - Clear
    
    mutating func clear() {
        for y in 0..<size {
            for x in 0..<size {
                matrix[y][x] = nil
            }
        }
    }
    
    // MARK: - Empty Cells
    
    var emptyIndices: [Index] {
        flatten.compactMap { $0.item == nil ? $0.index : nil }
    }
    
    var isFull: Bool {
        emptyIndices.isEmpty
    }
    
    func randomEmptyIndex() -> Index? {
        emptyIndices.randomElement()
    }
    
    // MARK: - Validation
    
    fileprivate func isIndexValid(_ index: Index) -> Bool {
        index.0 >= 0 && index.0 < size &&
        index.1 >= 0 && index.1 < size
    }
}
