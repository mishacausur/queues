//
//  ViewController.swift
//  MultiThreadHomeWork
//
//  Created by Alexey Golovin on 19.02.2021.
//
/*

 Разберитесь в коде, указанном в данном примере.
 Вам нужно определить где конкретно реализованы проблемы многопоточности (Race Condition, Deadlock) и укажите их. Объясните, из-за чего возникли проблемы.
 Попробуйте устранить эти проблемы.
 Готовый проект отправьте на проверку. 
 
*/

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        exampleOne()
//        exampleTwo()
    
    }
    
    func exampleOne() {
        var storage: [String] = []
        let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
        
        concurrentQueue.sync {
            print("1")
            for i in 0...1000 {
//                sleep(1)
                storage.append("Cell: \(i)")
            }
           
        }

        concurrentQueue.async {
            print("2")
            for i in 0...1000 {
                storage[i] = "Box: \(i)" //Race Condition проблема возникает из-за того, что вторая задача должна выполнячть вместе с первой, однако даннвые для ее выполнения еще не подготовлены
            }
           
        }
    }
    
    func exampleTwo() {
        print("a")
        DispatchQueue.main.async {
            DispatchQueue.main.async { // Deadlock проблема возникли из-за того, что  print("b") должен был печататься после print("c"), а print("c") после print("b") и возникал конфликт
                print("b")
            }
            print("c")
        }
        print("d")
    }
}


