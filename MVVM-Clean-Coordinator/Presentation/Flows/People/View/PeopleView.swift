//
//  PeopleView.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import SwiftUI

struct PeopleView: View {
    
    @ObservedObject var viewModel: PeopleViewModel
    
    var body: some View {
        switch viewModel.viewState {
        case .loading:
            Text("Loading...")
        case .loaded(let people):
            peopleList(people: people)
        case .error:
            Button("Error. Retry?", action: {
                viewModel.handleAction(.onRetryTap)
            })
        }
    }
    
    @ViewBuilder
    func peopleList(people: [People]) -> some View {
        List {
            ForEach(Array(people.enumerated()), id: \.offset) { (index, item) in
                PeopleRow(people: item)
                    .onTapGesture {
                        viewModel.handleAction(.onPeopleTap(String(index + 1)))
                    }
            }
        }
    }
}
