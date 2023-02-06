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
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)

        if let data = URLCache.shared.cachedResponse(for: request)?.data {
            print("got image from cache")
            // TODO: Add image cache [ Reference link: https://levelup.gitconnected.com/image-caching-with-urlcache-4eca5afb543a ]
            if let decoder = try? JSONDecoder().decode([String:[Lesson]].self, from: data){
                let lessons:[Lesson] = decoder["lessons"] ?? []
                DispatchQueue.main.async {
                    completion(lessons)
                }
            }else{
                DispatchQueue.main.async {
                    completion([])
                }
            }
        } else {
            print("got image from server")
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data,
                   let decoder = try? JSONDecoder().decode([String:[Lesson]].self, from: data)
                {
                    let lessons:[Lesson] = decoder["lessons"] ?? []
                    DispatchQueue.main.async {
                        completion(lessons)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }).resume()
        }
    }
}
