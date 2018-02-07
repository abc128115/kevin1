//
//  chatvc.swift
//  onlyone
//
//  Created by ios246 on 2018/2/2.
//  Copyright © 2018年 ios135. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase


class chatvc: JSQMessagesViewController {
    var messages = [JSQMessage]()
    private lazy var messageRef: DatabaseReference = Database.database().reference().child("messages")
    private var newMessageRefHandle: DatabaseHandle?
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage =
        self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage =
        self.setupIncomingBubble()
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    //
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAt indexPath: IndexPath!) ->
        JSQMessageBubbleImageDataSource! {
            let message = messages[indexPath.item] // 1
            if message.senderId == senderId { // 2
                return outgoingBubbleImageView
            } else { // 3
            }
            return incomingBubbleImageView
    }
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text:
            text) {
            
            messages.append(message)
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Auth.auth().signIn(withEmail:"kevin@abc.vcm",password: "kenken"){ (user, error) in
            // ...
            
        }
        
        
        self.senderId = Auth.auth().currentUser?.uid
        self.senderDisplayName="kevin"
        
        self.observeMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let itemRef = messageRef.childByAutoId() // 1
        let messageItem = [ // 2
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "text": text!,
            ]
        
        itemRef.setValue(messageItem) // 3
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        finishSendingMessage() // 5
        
        isTyping = false

        
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    // // //
    private func observeMessages() {
        //        messageRef = channelRef!.child("messages")
        // 1.
        let messageQuery = messageRef.queryLimited(toLast:25)
        // 2. We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            // 3
            let messageData = snapshot.value as! Dictionary<String, String>
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"]
                as String!, let text = messageData["text"] as String!, text.count > 0 {
                // 4
                self.addMessage(withId: id, name: name, text: text)
                // 5
            
            self.finishReceivingMessage()
        } else {
            print("Error! Could not decode message data")
        }
            })
    }
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
        print(textView.text != "")
        
        isTyping = textView.text != ""
    }
    private lazy var userIsTypingRef: DatabaseReference =
        Database.database().reference().child("typingIndicator").child(self.senderId)
    // 1
    private var localTyping = false
    // 2
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            // 3
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    private func observeTyping() {
        let typingIndicatorRef = Database.database().reference().child("typingIndicator")
        userIsTypingRef = typingIndicatorRef.child(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeTyping()
    }
    
    
        //
    //
    
    
    
    
//    override func collectionView(_ collectionView:
//        JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!)
//        -> JSQMessageAvatarImageDataSource! {
//            return nil
//    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt:
            indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
        }
        cell.textView?.textColor = UIColor.black
        return cell
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