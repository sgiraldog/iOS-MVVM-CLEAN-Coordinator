//
//  PeopleDetailView.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import SwiftUI

struct PeopleDetailView: View {
    
    @ObservedObject var viewModel: PeopleDetailViewModel
    
    var body: some View {
        switch viewModel.viewState {
        case .loading:
            Text("Loading...")
        case .loaded(let people):
            PeopleRow(people: people)
        case .error:
            Button("Error. Retry?", action: {
                viewModel.handleAction(.onRetryTap)
            })
        }
    }
}
