//
//  PeopleRow.swift
//  MVVM-Clean-Coordinator
//
//  Created by Sebastian on 10/12/24.
//

import SwiftUI

struct PeopleRow: View {
    let people: People
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(people.name)
            Text(people.height)
        }
    }
}

#Preview {
    PeopleRow(people: .init(name: "Sebastian", height: "180 cm"))
}
