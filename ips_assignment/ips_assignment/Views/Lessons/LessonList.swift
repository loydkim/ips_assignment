//
//  LessonsList.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-04.
//

import SwiftUI

struct LessonList: View {
    @Environment(\.colorScheme) var colorScheme
    var viewBG: Color{
        colorScheme == .dark ? Color(UIColor.systemGray5) : Color(UIColor.systemBackground)
    }
    @State var lessons: [Lesson] = []
    
//    init(){
//        UINavigationBar.appearance().backgroundColor = UIColor.systemGray5
//    }
    
    var body: some View{
        NavigationView {
            List {
                ForEach(Array(lessons.enumerated()), id: \.offset) { index, lesson in
                    // TODO: When touch the row, the background color should change
                    ZStack {
                        NavigationLink(destination: LessonDetailViewControllerWrapper(index: index, lessons: lessons)) {
                            EmptyView()
                        }
                        
                        HStack {
                            LessonRow(lesson: lesson)
                                .padding([.top,.bottom],2)
                        Spacer()
                        Image(systemName: "chevron.right")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 7)
                          .foregroundColor(.blue)
                        }
                        .foregroundColor(Color(UIColor.label))
                    }
//                    .listRowBackground(viewBG)
//                    .background(viewBG)
                }
            }
            .listStyle(InsetListStyle())
            .padding(.top,16)
//            .background(viewBG)
            .onAppear{
                ApiProvider().loadData { lessons in
                    self.lessons = lessons
                }
            }
            .navigationTitle("Lessons")
            .scrollContentBackground(.hidden)
        }
    }
}

struct LessonList_Preview: PreviewProvider{
    static var previews: some View{
        LessonList().preferredColorScheme(.dark)
    }
}
