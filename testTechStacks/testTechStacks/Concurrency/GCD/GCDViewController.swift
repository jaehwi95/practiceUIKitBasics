//
//  GCDViewController.swift
//  testTechStacks
//
//  Created by Jaehwi Kim on 2023/12/28.
//

import UIKit

class GCDViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var randomPokemonName: UILabel!
    @IBOutlet weak var timePassedText: UILabel!
    @IBOutlet weak var dispatchGroupStatus: UILabel!
    
    @IBOutlet weak var loadImageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addSyncTask(_ sender: UIButton) {
        let queue = DispatchQueue.global()
        queue.sync {
            sleep(1)
            print("task 1")
        }
        queue.sync {
            sleep(1)
            print("task 2")
        }
        queue.sync {
            sleep(1)
            print("task 3")
        }
    }
    
    @IBAction func addAsyncTask(_ sender: UIButton) {
        let queue = DispatchQueue.global()
        queue.async {
            sleep(1)
            print("task 1")
        }
        queue.async {
            sleep(1)
            print("task 2")
        }
        queue.async {
            sleep(1)
            print("task 3")
        }
    }
    
    @IBAction func taskSerialQueue(_ sender: Any) {
        let numbers = [0, 1, 2, 3, 4]
        let serialDispatchQueue = DispatchQueue(label: "Serial")
        (0..<5).forEach { index in
            serialDispatchQueue.async {
                print(numbers[index])
            }
        }
    }
    
    @IBAction func taskConcurrentQueue(_ sender: Any) {
        let numbers = [0, 1, 2, 3, 4]
        let concurrentDispatchQueue = DispatchQueue(label: "Concurrent", attributes: .concurrent)
        (0..<5).forEach { index in
            concurrentDispatchQueue.async {
                print(numbers[index])
            }
        }
    }
    
    @IBAction func getImage(_ sender: UIButton) {
        GCDNetworkService.shared.getPepeImage { data in
            // UI 업데이트는 main thread 명시
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
        self.loadImageButton.tintColor = UIColor.red
    }
    
    @IBAction func getPokemon(_ sender: UIButton) {
        GCDNetworkService.shared.getRandomPokemonName { result in
            // UI 업데이트임으로 main thread
            DispatchQueue.main.async() {
                self.randomPokemonName.text = result
            }
        }
    }
    
    @IBAction func call1SecondTask(_ sender: Any) {
        GCDNetworkService.shared.getStringAfter1Seconds { result in
            DispatchQueue.main.async() {
                self.timePassedText.text = result
            }
        }
    }
    
    @IBAction func call3SecondTask(_ sender: Any) {
        GCDNetworkService.shared.getStringAfter3Seconds { result in
            DispatchQueue.main.async() {
                self.timePassedText.text = result
            }
        }
    }
    
    @IBAction func call5SecondTask(_ sender: Any) {
        GCDNetworkService.shared.getStringAfter5Seconds { result in
            DispatchQueue.main.async() {
                self.timePassedText.text = result
            }
        }
    }
    
    @IBAction func testDispatchGroup(_ sender: UIButton) {
        self.dispatchGroupStatus.text = "DispatchGroupStatus: Start"
        let group = DispatchGroup()
        DispatchQueue.global().async(group: group) {
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {}
            DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {}
            DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {}
        }
        DispatchQueue.global(qos: .background).async(group: group) {
            GCDNetworkService.shared.getRandomPokemonName { result in
                print("get pokemon: \(result) done")
            }
            GCDNetworkService.shared.getPepeImage { data in
                print("get pepe image done")
            }
        }
        group.wait()
        group.notify(queue: .main) {
            self.dispatchGroupStatus.text = "DONE!"
        }
    }
    
    @IBAction func activatePyramidOfDoom(_ sender: UIButton) {
        var sumAllString: String = ""
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async() {
            GCDNetworkService.shared.getStringAfter5Seconds { result1 in
                GCDNetworkService.shared.getStringAfter3Seconds { result2 in
                    GCDNetworkService.shared.getStringAfter1Seconds { result3 in
                        GCDNetworkService.shared.getRandomPokemonName { result4 in
                            sumAllString = result1+result2+result3+result4
                            semaphore.signal()
                        }
                    }
                }
            }
        }
        semaphore.wait()
        timePassedText.text = sumAllString
    }
}
