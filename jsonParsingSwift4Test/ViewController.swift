//
//  ViewController.swift
//  jsonParsingSwift4Test
//
//  Created by Emiko Clark on 3/11/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
}

struct WebsiteDescription: Decodable {
    let name: String?
    let description: String?
    let courses: [Course]?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get individual course info
        getSingleCourseInfo()
        
        // get website description with array of courses
        getCoursesInfo()
        
        // get website description with missing fields
        getCoursesInfoWithMissingFields()
    }
    
    func getSingleCourseInfo() {
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        guard let urlRequest = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // ensure data is not nil
            guard let data = data else { print("error- data is nil"); return }
            
            do {
                // ensure decoding worked
                let course =  try JSONDecoder().decode(Course.self, from: data)
                
                guard let id = course.id,
                    let name = course.name,
                    let link = course.link,
                    let imageURL = course.imageUrl
                    else { print("error unwrapping and decoding json"); return }
                print("\n Individual course info\n",id, name, link, imageURL)
                
            } catch {
                print("error converting json")
            }
            
            }.resume()
    }
    
    func getCoursesInfo() {
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        guard let urlRequest = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { print("error- data is nil"); return }
            print(data)
            
            do {
                let websiteDescription =  try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print("\n Website description with array of courses\n", websiteDescription.name as Any, websiteDescription.description as Any, websiteDescription.courses as Any )
            } catch {
                print("error converting json")
            }
            
            }.resume()
    }
    
    func getCoursesInfoWithMissingFields() {
        let apiUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        guard let urlRequest = URL(string: apiUrlString) else {return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { print("error getting data"); return }
            
            do {
                let coursesMissingFields = try JSONDecoder().decode([Course].self, from: data)
                print("\n Website description with missing fields\n", coursesMissingFields)
            } catch {
                print("error decoding courses missing fields")
            }
        }.resume()
    }
}

//==============================================================================
// below are jsons returned by the 3 functions

// json: "https://api.letsbuildthatapp.com/jsondecodable/course"
//{
//    "id": 1,
//    "name": "Instagram Firebase",
//    "link": "https:\/\/www.letsbuildthatapp.com\/course\/instagram-firebase",
//    "imageUrl": "https:\/\/letsbuildthatapp-videos.s3-us-west-2.amazonaws.com\/04782e30-d72a-4917-9d7a-c862226e0a93"
//}

// json: "https://api.letsbuildthatapp.com/jsondecodable/website_description"
//{
//    "name": "Lets Build That App",
//    "description": "Teaching and Building Apps since 1999",
//    "courses": [
//    {
//    "id": 1,
//    "name": "Instagram Firebase",
//    "link": "https:\/\/www.letsbuildthatapp.com\/course\/instagram-firebase",
//    "imageUrl": "https:\/\/letsbuildthatapp-videos.s3-us-west-2.amazonaws.com\/04782e30-d72a-4917-9d7a-c862226e0a93"
//    },
//    {
//    "id": 3,
//    "name": "Kindle Basic Training",
//    "link": "https:\/\/www.letsbuildthatapp.com\/basic-training",
//    "imageUrl": "https:\/\/letsbuildthatapp-videos.s3-us-west-2.amazonaws.com\/a6180731-c077-46e7-88d5-4900514e06cf"
//    }
//    ]
//}

// json: "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
//[
//    {
//        "id": 1,
//        "name": "Instagram Firebase",
//        "link": "https:\/\/www.letsbuildthatapp.com\/course\/instagram-firebase",
//        "imageUrl": "https:\/\/letsbuildthatapp-videos.s3-us-west-2.amazonaws.com\/04782e30-d72a-4917-9d7a-c862226e0a93"
//    },
//    {
//        "id": 3,
//        "name": "Kindle Basic Training",
//        "link": "https:\/\/www.letsbuildthatapp.com\/basic-training",
//        "imageUrl": "https:\/\/letsbuildthatapp-videos.s3-us-west-2.amazonaws.com\/a6180731-c077-46e7-88d5-4900514e06cf"
//    },
//    {
//        "name": "Yelp"
//    }
//]

