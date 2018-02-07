//
//  ViewController.swift
//  kevin1
//
//  Created by ios135 on 2017/12/22.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBOutlet weak var bomb: UIImageView!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var enter: UITextField!
    @IBOutlet weak var answer: UILabel!
  
    
    var  generate=0
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        generate=Int(arc4random_uniform(100))
    }
    
    @IBAction func OK(_ sender: Any) {
        let i=Int(enter.text!)!
        decide(test: i)
        }
    
    func decide(test:Int){
        let secrect=generate
        
        var intNum1=Int(number1.text!)!
        var intNum2=Int(number2.text!)!
        
        if test > intNum1 && test < intNum2{
        if test>secrect{
            number2.text = String(test)
            enter.text = ""
        }else if test<secrect{
        number1.text = String(test)
        enter.text = ""
        }else{
            answer.text = "恭喜你爆炸了!炸彈是\(secrect)"
            enter.text = ""
            bomb.image = #imageLiteral(resourceName: "boom2.png")
            }
        enter.resignFirstResponder()
        }
    }
    @IBAction func restart(_ sender: UIButton) {
        enter.text = ""
        generate = Int(arc4random_uniform(100))
        number1.text = "1"
        number2.text = "100"
        answer.text  = "未爆炸"
        bomb.image = #imageLiteral(resourceName: "boom.png")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
