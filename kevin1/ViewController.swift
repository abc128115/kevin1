//
//  ViewController.swift
//  kevin1
//
//  Created by ios135 on 2017/12/22.
//  Copyright © 2017年 ios135. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            do{
                try AVAudioSession.sharedInstance().setActive(true)
            }catch{
                
            }
        }catch{
            
        }
        // Do any additional setup after loading the view.
        self.playSound1()
        generate=Int(arc4random_uniform(100))
        
    }
    @IBOutlet weak var bomb: UIImageView!
    @IBOutlet weak var number1: UILabel!
    @IBOutlet weak var number2: UILabel!
    @IBOutlet weak var enter: UITextField!
    @IBOutlet weak var answer: UILabel!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var player: AVAudioPlayer?
    var  generate=0
    func playSound() {
        guard let url = Bundle.main.url(forResource: "boom", withExtension: "mp3")
            else { return }
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint:
                AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        } catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    
    func playSound1() {
        guard let url = Bundle.main.url(forResource: "tension", withExtension: "mp3")
            else { return }
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint:
                AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
            player.numberOfLoops = -1
        } catch let error
        {
            print(error.localizedDescription)
        }
    }
    func stop()   {
        print("stop")
        player?.stop()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        
        ////        self.playSound1()
        //        generate=Int(arc4random_uniform(10))
        
    }
    
    @IBAction func OK(_ sender: Any) {
        if let i=Int(enter.text!){
            decide(test: i)
        }else{
            let alertController = UIAlertController(title: "遊戲提示",
                                                    message: "未輸入", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "確定", style: .default, handler: {
                action in
                print("點擊了確定")
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            print("wrong!")
        }
        
    }
    
    func decide(test:Int){
        let secrect=generate
        
        var intNum1=Int(number1.text!)!
        var intNum2=Int(number2.text!)!
        
        
        if test >= intNum1 && test <= intNum2{
            if test>secrect{
                number2.text = String(test)
                enter.text = ""
                let okspeak = number1.text!+"到"+number2.text!
                myUtterance = AVSpeechUtterance(string:okspeak)
                myUtterance.rate = 0.4
                myUtterance.pitchMultiplier = 1.2
                myUtterance.postUtteranceDelay = 0.1
                myUtterance.volume = 1
                myUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                synth.speak(myUtterance)
            }else if test<secrect{
                number1.text = String(test)
                enter.text = ""
                let okspeak = number1.text!+"到"+number2.text!
                myUtterance = AVSpeechUtterance(string:okspeak)
                myUtterance.rate = 0.4
                myUtterance.pitchMultiplier = 1.2
                myUtterance.postUtteranceDelay = 0.1
                myUtterance.volume = 1
                myUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                synth.speak(myUtterance)
            }else{
                enter.isEnabled=false
                self.stop()
                answer.text = "恭喜你爆炸了!炸彈是\(secrect)"
                enter.text = ""
                bomb.image = #imageLiteral(resourceName: "boom2.png")
                self.playSound()
                let boomspeak = "糟糕了爆炸了"
                myUtterance = AVSpeechUtterance(string:boomspeak)
                myUtterance.rate = 0.4
                myUtterance.pitchMultiplier = 1.2
                myUtterance.postUtteranceDelay = 0.1
                myUtterance.volume = 1
                myUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                synth.speak(myUtterance)
            }
            enter.resignFirstResponder()
            
        }
    }
    @IBAction func restart(_ sender: UIButton) {
        enter.isEnabled=true
        enter.text = ""
        generate = Int(arc4random_uniform(100))
        number1.text = "1"
        number2.text = "10"
        answer.text  = "未爆炸"
        bomb.image = #imageLiteral(resourceName: "boom.png")
        self.playSound1()
        
    }
    
    
    @IBAction func back(_ sender: UIButton) {
        self.stop()
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
