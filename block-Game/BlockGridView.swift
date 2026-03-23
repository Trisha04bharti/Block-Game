//
//  BlockGridView.swift
//  block-Game
//
//  Created by Vikram Kumar on 16/03/26.
//
import SwiftUI

// MARK: - Model

struct IdentifiedBlock: Identifiable, Equatable {
    let id: Int
    let number: Int
}

struct IndexedBlock<T> {
    let index: (Int, Int)
    let item: T?
}

struct BlockMatrix<T> {
    private var storage: [[T?]] = Array(
        repeating: Array(repeating: nil, count: 4),
        count: 4
    )
    
    mutating func place(_ item: T, to index: (Int, Int)) {
        storage[index.1][index.0] = item
    }
    
    var flatten: [IndexedBlock<T>] {
        var result: [IndexedBlock<T>] = []
        
        for y in 0..<4 {
            for x in 0..<4 {
                result.append(
                    IndexedBlock(index: (x, y), item: storage[y][x])
                )
            }
        }
        return result
    }
}

// MARK: - Identifiable Wrapper

fileprivate struct IdentifiableIndexedBlock: Identifiable {
    
    typealias ID = String
    
    static var uniqueBlankId = 0
    
    let indexedBlock: IndexedBlock<IdentifiedBlock>
    
    var id: String {
        if let id = indexedBlock.item?.id {
            return "\(id)"
        }
        
        IdentifiableIndexedBlock.uniqueBlankId += 1
        return "Blank_\(IdentifiableIndexedBlock.uniqueBlankId)"
    }
    
    var item: IdentifiedBlock? {
        indexedBlock.item
    }
    
    var index: (Int, Int) {
        indexedBlock.index
    }
}

// MARK: - Transition

extension AnyTransition {
    
    static func blockAppear(from edge: Edge) -> AnyTransition {
        .asymmetric(
            insertion: .scale(scale: 0.5)
                .combined(with: .opacity)
                .combined(with: .move(edge: edge)),
            removal: .identity
        )
    }
}

// MARK: - Block View

struct BlockView: View {
    let number: Int?
    
    static func blank() -> BlockView {
        BlockView(number: nil)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
            
            if let number = number {
                Text("\(number)")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .scaleEffect(number == nil ? 1.0 : 1.05)
        .animation(.easeInOut(duration: 0.2), value: number)
    }
    
    var backgroundColor: Color {
        switch number {
        case 2: return .yellow
        case 4: return .orange
        case 8: return .red
        case 16: return .purple
        case 32: return .blue
        case 64: return .green
        case 128: return .teal
        case 256: return .indigo
        case 512: return .pink
        case 1024: return .black
        case 2048: return .gray
        default: return Color.gray.opacity(0.3)
        }
    }
}

// MARK: - Grid View

struct BlockGridView: View {
    
    typealias SupportingMatrix = BlockMatrix<IdentifiedBlock>
    
    let matrix: SupportingMatrix
    let blockEnterEdge: Edge
    
    func createBlock(_ block: IdentifiedBlock?) -> some View {
        if let block = block {
            return BlockView(number: block.number)
        }
        return BlockView.blank()
    }
    
    func zIndex(_ block: IdentifiedBlock?) -> Double {
        block == nil ? 1 : 1000
    }
    
    var body: some View {
        ZStack {
            ForEach(
                matrix.flatten.map { IdentifiableIndexedBlock(indexedBlock: $0) }
            ) { block in
                
                createBlock(block.item)
                    .frame(width: 65, height: 65)
                    .position(
                        x: CGFloat(block.index.0) * (65 + 12) + 32.5 + 12,
                        y: CGFloat(block.index.1) * (65 + 12) + 32.5 + 12
                    )
                    .zIndex(zIndex(block.item))
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
                    .transition(.blockAppear(from: blockEnterEdge))
                    .animation(
                        block.item == nil ? nil :
                        .spring(response: 0.3, dampingFraction: 0.7),
                        value: block.id
                    )
            }
        }
        .frame(width: 320, height: 320)
        .background(
            Rectangle()
                .fill(Color(red: 0.72, green: 0.66, blue: 0.63))
        )
        .cornerRadius(8)
    }
}

// MARK: - Preview

#if DEBUG
struct BlockGridView_Previews: PreviewProvider {
    
    static var matrix: BlockGridView.SupportingMatrix {
        var m = BlockGridView.SupportingMatrix()
        m.place(IdentifiedBlock(id: 1, number: 2), to: (2, 0))
        m.place(IdentifiedBlock(id: 2, number: 4), to: (3, 0))
        m.place(IdentifiedBlock(id: 3, number: 8), to: (1, 1))
        m.place(IdentifiedBlock(id: 4, number: 16), to: (2, 1))
        m.place(IdentifiedBlock(id: 5, number: 512), to: (3, 3))
        m.place(IdentifiedBlock(id: 6, number: 1024), to: (2, 3))
        m.place(IdentifiedBlock(id: 7, number: 32), to: (0, 3))
        m.place(IdentifiedBlock(id: 8, number: 64), to: (1, 3))
        return m
    }
    
    static var previews: some View {
        BlockGridView(matrix: matrix, blockEnterEdge: .top)
            .previewLayout(.sizeThatFits)
    }
}
#endif
