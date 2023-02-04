//
//  LessonsRow.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import SwiftUI

struct LessonRow: View {
    var lesson: Lesson
    var body: some View{
        HStack {
            AsyncImage(url: URL(string:lesson.thumbnail)) { image in
                image
                    .resizable()
                    .frame(width:90,height:64)
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            Text(lesson.name)
        }
    }
}

struct LessonRow_Preview: PreviewProvider{
    static var lessons = ModelData().lessons
    
    static var previews: some View{
        Group {
            LessonRow(lesson: lessons[0])
            LessonRow(lesson: lessons[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
        .preferredColorScheme(.dark)
    }
}
