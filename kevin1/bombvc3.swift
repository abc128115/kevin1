//
//  bombvc3.swift
//  kevin1
//
//  Created by ios246 on 2018/1/31.
//  Copyright © 2018年 ios135. All rights reserved.
//

import UIKit

class bombvc3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var bomb: UIImageView!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var enter: UITextField!
    @IBOutlet weak var answer: UILabel!
    
    
    var  generate=0
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        generate=Int(arc4random_uniform(1000))
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
        generate = Int(arc4random_uniform(1000))
        number1.text = "1"
        number2.text = "1000"
        answer.text  = "未爆炸"
        bomb.image = #imageLiteral(resourceName: "boom.png")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
