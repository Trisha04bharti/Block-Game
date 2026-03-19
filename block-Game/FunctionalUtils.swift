//
//  FunctionalUtils.swift
//  block-Game
//
//  Created by Vikram Kumar on 19/03/26.
//

import Foundation

func bind<T, U>(_ x: T, _ closure: (T) -> U) -> U {
    return closure(x)
}
