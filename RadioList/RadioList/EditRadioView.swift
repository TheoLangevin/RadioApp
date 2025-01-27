//
//  EditRadioView.swift
//  RadioList
//
//  Created by ENSISA on 09/01/2025.
//


import SwiftUI

struct EditRadioView: View {
    @State private var name: String
    @State private var category: String
    @State private var url: String

    var onSave: (String, String, String) -> Void

    init(radio: Radio, onSave: @escaping (String, String, String) -> Void) {
        _name = State(initialValue: radio.name)
        _category = State(initialValue: radio.category)
        _url = State(initialValue: radio.url)
        self.onSave = onSave
    }

    var body: some View {
        Form {
            Section(header: Text("Nom")) {
                TextField("Nom de la radio", text: $name)
            }
            Section(header: Text("Catégorie")) {
                TextField("Catégorie", text: $category)
            }
            Section(header: Text("URL")) {
                TextField("URL du flux", text: $url)
            }
        }
        .navigationBarItems(trailing: Button("Enregistrer") {
            // Validation avant d’enregistrer
            if !name.isEmpty && !category.isEmpty && !url.isEmpty {
                onSave(name, category, url)
            }
        })
        .navigationBarTitle("Éditer la radio", displayMode: .inline)
    }
}
