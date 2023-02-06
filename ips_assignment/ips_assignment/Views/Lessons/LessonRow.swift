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
            // TODO: This View is available iOS 15.0.
            // Should consider under 15 version user
            AsyncImage(url: URL(string:lesson.thumbnail)) { image in
                image
                    .resizable()
                    .frame(width:110,height:64)
                    .cornerRadius(6)
//                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.gray)
                    .frame(width:110,height:64)
            }

            Text(lesson.name)
                .padding([.leading, .trailing], 6)
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
