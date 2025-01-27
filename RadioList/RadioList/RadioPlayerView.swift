import AVKit
import SwiftUI

struct RadioPlayerView: View {
    var radio: Radio
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var editedRadio: Radio // Ajouter une variable pour la radio éditée

    // Ajoute un callback pour mettre à jour les infos de la radio après modification
    @State private var showEditView = false
    
    init(radio: Radio) {
        self.radio = radio
        _editedRadio = State(initialValue: radio) // Initialiser avec les données actuelles
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text(editedRadio.name) // Utilise la version modifiée si nécessaire
                    .font(.title)
                    .padding()
                
                HStack {
                    Button(action: {
                        if self.isPlaying {
                            self.player?.pause()
                        } else {
                            self.startPlaying()
                        }
                        self.isPlaying.toggle()
                    }) {
                        Text(isPlaying ? "Pause" : "Écouter")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // Utilisation de NavigationLink avec action de navigation
                    NavigationLink(
                        destination: EditRadioView(radio: editedRadio, onSave: saveChanges)
                            .onDisappear {
                                // Si tu veux que la radio éditée soit sauvegardée quand l'utilisateur revient
                            },
                        isActive: $showEditView
                    ) {
                        Text("Modifier")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .onAppear {
                // Vérification que la connexion Internet est disponible
                guard let url = URL(string: radio.url) else { return }
                player = AVPlayer(url: url)
            }
            .navigationBarTitle("Écouter: \(editedRadio.name)", displayMode: .inline)
        }
    }

    // Fonction pour démarrer la lecture
    func startPlaying() {
        player?.play()
    }

    // Fonction de sauvegarde pour mettre à jour les données après l'édition
    func saveChanges(name: String, category: String, url: String) {
        editedRadio.name = name
        editedRadio.category = category
        editedRadio.url = url
    }
}
