import SwiftUI

// Modèle de la radio
//struct Radio: Identifiable {
//    var id = UUID()
//    var name: String
//    var category: String
//    var url: String
//}


struct ContentView: View {

    @State private var radios: [Radio] = [
        Radio(name: "RTL", category: "Généraliste", url: "http://streaming.radio.rtl.fr/rtl-1-44-128"),
        Radio(name: "France Musique", category: "Musique", url: "http://direct.francemusique.fr/live/francemusique-lofi.mp3"),
        Radio(name: "NRJ", category: "Pop", url: "http://streaming.radio.nrj.fr/nrj-1-44-128")
    ]
    
    @State private var showingCreateRadioView = false  // Pour afficher CreateRadioView
    private var categories: [String] {
        // Extraire les catégories uniques existantes
        Array(Set(radios.map { $0.category })).sorted()
    }

    var body: some View {
        NavigationView {
            List {
                // Groupement des radios par catégorie
                ForEach(Array(Dictionary(grouping: radios, by: { $0.category }).keys), id: \.self) { category in
                    Section(header: Text(category)) {
                        // Récupérer les radios pour la catégorie actuelle
                        ForEach(radios.filter { $0.category == category }) { radio in
                            NavigationLink(destination: RadioPlayerView(radio: radio)) {
                                Text(radio.name)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Radios")
            .navigationBarItems(trailing: Button(action: {
                showingCreateRadioView.toggle()  // Ouvre la vue de création de radio
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            })
            .sheet(isPresented: $showingCreateRadioView) {
                CreateRadioView(
                    existingCategories: categories,
                    onSave: { name, category, url in
                        let newRadio = Radio(name: name, category: category, url: url)
                        radios.append(newRadio)  // Ajoute la radio à la liste
                        showingCreateRadioView = false  // Ferme la vue de création
                    }
                )
            }
        }
    }
}
