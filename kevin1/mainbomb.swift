//
//  mainbomb.swift
//  kevin1
//
//  Created by ios246 on 2018/1/29.
//  Copyright © 2018年 ios135. All rights reserved.
//

import UIKit
import AVFoundation
class mainbomb: UIViewController {
//only one
    var player: AVAudioPlayer?
    func playSound() {
        guard let url = Bundle.main.url(forResource: "happy", withExtension: "mp3")
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
        player?.stop()
    }
    @IBAction func stop(_ sender: UIButton) {
      self.stop()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playSound()
        // Do any additional setup after loading the view.
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
