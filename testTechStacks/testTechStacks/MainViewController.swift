//
//  MainViewController.swift
//  testTechStacks
//
//  Created by Jaehwi Kim on 2023/12/27.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

func decodeJson() {
    let data: Data = #"{ "jsonKeyName1": "123", "jsonKeyName2": "456"}"#.data(using: .utf8)!
    let result: JsonModel? = try? JSONDecoder().decode(JsonModel.self, from: data)
}

struct JsonModel: Codable {
    let property1: String
    let property2: String
    
    enum CodingKeys: String, CodingKey {
        case property1 = "jsonKeyName1"
        case property2 = "jsonKeyName2"
    }
}
