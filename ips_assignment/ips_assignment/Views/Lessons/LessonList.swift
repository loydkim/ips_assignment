//
//  LessonsList.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import SwiftUI

struct LessonList: View {
    var modelData: ModelData
    var body: some View{
        NavigationView {
            List {
                ForEach(modelData.lessons) { lesson in
                    NavigationLink{
                        LessonDetail()
                    } label:{
                        LessonRow(lesson: lesson)
                    }
                    
                }
            }
            .navigationTitle("Lessons")
        }
    }
}

struct LessonList_Preview: PreviewProvider{
    static var previews: some View{
        LessonList(modelData: ModelData()).preferredColorScheme(.dark)
    }
}
