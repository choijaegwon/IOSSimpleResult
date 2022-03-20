//
//  ViewController.swift
//  Dispatch_Queue2
//
//  Created by Jae kwon Choi on 2021/12/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var finishLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {
            timer in
            self.timerLabel.text = Date().timeIntervalSince1970.description
        }

    }
    
    @IBAction func action1(_ sender: Any) {
        
        simpleClosure {
            DispatchQueue.main.async {
                self.finishLabel.text = "끝"
            }
        }
        
    }
    
    func simpleClosure(completion: @escaping () -> Void) {
        
        DispatchQueue.global().async {
         
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.3)
                print(index)
            }
                completion()
            
        }
    }
    
    @IBAction func action2(_ sender: Any) {
        
        let dispatchGroup = DispatchGroup()
        
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")
        
        queue1.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.3)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        queue2.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.3)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        queue3.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for index in 20..<30 {
                    Thread.sleep(forTimeInterval: 0.3)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
    }
    
    @IBAction func action3(_ sender: Any) {
    
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")

        // 내가 최우선이다 sync
        // 다른애들은 다 멈춰 내가 최우선으로 한다.
        queue1.sync {
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.3)
                    print(index)
                }
        }
        
        queue2.sync {
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.3)
                    print(index)
                }
            }
    }
}

