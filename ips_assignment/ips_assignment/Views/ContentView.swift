//
//  ContentView.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LessonList(modelData: ModelData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
