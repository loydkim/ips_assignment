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
    
    var body: some View{
        NavigationView {
            List {
                ForEach(lessons) { lesson in
                    ZStack {
                        NavigationLink(destination: LessonDetail()) {
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
                    .listRowBackground(viewBG)
                    .background(viewBG)
                }
            }
            .listStyle(InsetListStyle())
            .padding(.top,16)
            .background(viewBG)
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
