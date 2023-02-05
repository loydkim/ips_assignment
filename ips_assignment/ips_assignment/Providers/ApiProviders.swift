//
//  ApiProviders.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-05.
//

import Foundation

class ApiProvider : ObservableObject{
    @Published var Lessons = [Lesson]()
    
    func loadData(completion:@escaping ([Lesson]) -> ()) {
        guard let url = URL(string: "https://iphonephotographyschool.com/test-api/lessons") else {
            print("Invalid url")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if(data != nil){
                let decoder = try? JSONDecoder().decode([String:[Lesson]].self, from: data!)
                if(decoder != nil){
                    let lessons:[Lesson] = decoder!["lessons"] ?? []
                    print(lessons)
                    DispatchQueue.main.async {
                        completion(lessons)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }else{
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}
