//
//  Radio.swift
//  RadioList
//
//  Created by ENSISA on 27/01/2025.
//

import SwiftUI
import AVKit

struct Radio: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var url: String
}

class Category {
    var name: String
    var radios: [Radio]

    init(name: String) {
        self.name = name
        self.radios = []
    }

    func findRadio(name: String) -> Radio? {
        return radios.first { $0.name == name }
    }

    func delete(radio: Radio) {
        if let index = radios.firstIndex(where: { $0.id == radio.id }) {
            radios.remove(at: index)
        }
    }

    func addRadio(radio: Radio) {
        if findRadio(name: radio.name) == nil {
            radios.append(radio)
        }
    }
}

class RadioManager {
    static var shared = RadioManager()
    var categories: [Category]

    private init() {
        self.categories = []
    }

    func findCategory(name: String) -> Category? {
        return categories.first { $0.name == name }
    }

    func delete(radio: Radio) {
        categories.forEach { category in
            category.delete(radio: radio)
        }
    }

    func addCategory(category: Category) {
        if findCategory(name: category.name) == nil {
            categories.append(category)
        }
    }

    func addRadioToCategory(radio: Radio, categoryName: String) {
        if let category = findCategory(name: categoryName) {
            category.addRadio(radio: radio)
        } else {
            let newCategory = Category(name: categoryName)
            newCategory.addRadio(radio: radio)
            addCategory(category: newCategory)
        }
    }
}
