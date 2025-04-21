//
//  ViewNavigatable.swift
//  CookBook
//
//  Created by Kirill Faifer on 22.04.2025.
//

import SwiftUICore
import UIKit.UINavigationController

protocol ViewNavigatable: View {
    var navigationController: UINavigationController { get }
}
