//
//  UICollectionViewCell+ReuseIdentifier.swift
//  wheelPicker
//
//  Created by katya on 5.03.23.
//


import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

