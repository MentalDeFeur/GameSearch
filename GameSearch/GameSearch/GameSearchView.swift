//
//  GameSearchView.swift
//  
//
//  Created by Joffrey TERRINE on 07/09/2025.
//

// GameSearchView.swift
import SwiftUI

struct GameSearchView: View {
    @StateObject var vm = GameSearchViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.results) { game in
                    NavigationLink(value: game) { GameRow(game: game) }
                }
                if vm.isLoading { ProgressView().frame(maxWidth: .infinity) }
                else if vm.hasMore {
                    Button("Charger plus") { Task { await vm.search(reset: false) } }
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationDestination(for: Game.self) { GameDetailView(game: $0) }
            .navigationTitle("Jeux vidéo")
            .searchable(text: $vm.query, placement: .navigationBarDrawer, prompt: "Rechercher un jeu…")
            .onChange(of: vm.query){ vm.onQueryChange() }
            .task { /* optionnel: recherches suggérées */ }
        }
    }
}

struct GameRow: View {
    let game: Game
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: game.background_image ?? "")) { img in
                img.resizable().scaledToFill()
            } placeholder: { Color.gray.opacity(0.2) }
            .frame(width: 72, height: 72).clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {
                Text(game.name).font(.headline).lineLimit(2)
                if let plats = game.parent_platforms?.map({ $0.platform.name }).joined(separator: " · "),
                   !plats.isEmpty {
                    Text(plats).font(.subheadline).foregroundStyle(.secondary)
                }
                if let rating = game.rating { Text("⭐️ \(String(format: "%.1f", rating))").font(.caption) }
            }
        }
    }
}

struct GameDetailView: View {
    let game: Game
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                AsyncImage(url: URL(string: game.background_image ?? "")) { $0.resizable().scaledToFit() }
                    placeholder: { Rectangle().fill(.gray.opacity(0.2)).frame(height: 200) }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                Text(game.name).font(.title).bold()
                if let date = game.released { Text("Sortie : \(date)").foregroundStyle(.secondary) }
                // Ajoute ici genres, description, screenshots (via autre endpoint)
            }
            .padding()
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview{
    GameSearchView()
}

