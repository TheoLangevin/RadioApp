import SwiftUI

struct CreateRadioView: View {
    @State private var name: String
    @State private var category: String
    @State private var url: String
    @State private var isCustomCategory = false  // Pour gérer l'option de création d'une nouvelle catégorie

    var existingCategories: [String]
    var onSave: (String, String, String) -> Void

    init(existingCategories: [String], onSave: @escaping (String, String, String) -> Void) {
        _name = State(initialValue: "")
        _category = State(initialValue: "")
        _url = State(initialValue: "")
        self.existingCategories = existingCategories
        self.onSave = onSave
    }

    var body: some View {
    
        Form {
            Section(header: Text("Nom")) {
                TextField("Nom de la radio", text: $name)
            }

            Section(header: Text("Catégorie")) {
                Picker("Catégorie", selection: $category) {
                    ForEach(existingCategories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Toggle("Créer une nouvelle catégorie", isOn: $isCustomCategory)
                    

                if isCustomCategory {
                    TextField("Nouvelle catégorie", text: $category)
                }
            }

            Section(header: Text("URL")) {
                TextField("URL du flux", text: $url)
                    .keyboardType(.URL)
            }
        }

        Button("Enregistrer") {
            // Validation avant d’enregistrer
            if !name.isEmpty && !category.isEmpty && !url.isEmpty {
                onSave(name, category, url)
            }
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
