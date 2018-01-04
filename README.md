//
//  ChatVC.swift
//  chat app
//
//  Created by Hitesh Thummar on 05/11/17.
//  Copyright © 2017 Hitesh Thummar. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
 
    var chatArray:[NSMutableDictionary] = [NSMutableDictionary]();
    let cellId = "cellID"
    @IBOutlet weak var dataCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var dict = NSMutableDictionary()
        dict.setValue("Hiiiiiii", forKey: "msg")
        dict.setValue(true, forKey: "sender")
        
        chatArray.append(dict);
        
        dict = NSMutableDictionary()
        dict.setValue("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled", forKey: "msg")
        dict.setValue(false, forKey: "sender")
        chatArray.append(dict);
        
        dict = NSMutableDictionary()
        dict.setValue("call me", forKey: "msg")
        dict.setValue(true, forKey: "sender")
        chatArray.append(dict);
        
        
        dict = NSMutableDictionary()
        dict.setValue("it to make a type specimen book. It has survived not only five", forKey: "msg")
        dict.setValue(true, forKey: "sender")
        chatArray.append(dict);
        
        
        dict = NSMutableDictionary()
        dict.setValue("for party", forKey: "msg")
        dict.setValue(true, forKey: "sender")
        chatArray.append(dict);
        
        
        dict = NSMutableDictionary()
        dict.setValue("it to make a type specimen book. It has survived not only five", forKey: "msg")
        dict.setValue(true, forKey: "sender")
        chatArray.append(dict);
        
       
        dict = NSMutableDictionary()
        dict.setValue("So where should I reset all constraints? At the very beginning of the cellForIndexPath? I have tried doing this, but it doesn't change anything", forKey: "msg")
        dict.setValue(true, forKey: "sender")
        chatArray.append(dict);
        
        
        dict = NSMutableDictionary()
        dict.setValue("So", forKey: "msg")
        dict.setValue(false, forKey: "sender")
        chatArray.append(dict);
        
        
        
        
        
        dataCV?.register(chatCell.self, forCellWithReuseIdentifier: cellId);
        dataCV?.dataSource = self;
        dataCV?.delegate = self
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatArray.count;
    }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! chatCell;
        cell.textView.text = chatArray[indexPath.row].value(forKey: "msg") as! String;
        
        
        let dict = chatArray[indexPath.row]
        
        if let msg = cell.textView.text
        {
            let size = CGSize(width: 250, height: 1000);
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin);
            let estimatedFrame = NSString(string: msg).boundingRect(with: size, options: option, attributes: [kCTFontAttributeName as NSAttributedStringKey:UIFont.systemFont(ofSize: 18)], context: nil);
            
            if dict.value(forKey: "sender") as! Bool == false
            {
            
                cell.buubleView.frame = CGRect(x: cell.userImg.frame.origin.x + cell.userImg.frame.width + 8, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20);
                cell.textView.frame = CGRect(x: cell.userImg.frame.origin.x + cell.userImg.frame.width + 8 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20);
            }
            else
            {
                cell.buubleView.frame = CGRect(x: cell.userImg.frame.origin.x + cell.userImg.frame.width + 8, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20);
                cell.textView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 8 - 8 - cell.y, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20);
                
            }
            
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let msg = chatArray[indexPath.row].value(forKey: "msg") as? String
        {
            let size = CGSize(width: 250, height: 1000);
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin);
            let estimatedFrame = NSString(string: msg).boundingRect(with: size, options: option, attributes: [kCTFontAttributeName as NSAttributedStringKey:UIFont.systemFont(ofSize: 18)], context: nil);
            return CGSize(width: self.view.frame.width, height: estimatedFrame.height + 20);
        }
        
        return CGSize(width: self.view.frame.width, height: 80);
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0);
    }
}



class chatCell:UICollectionViewCell {
    
    
    var textView:UITextView = {
        let txt = UITextView();
        txt.font = UIFont.systemFont(ofSize: 18)
        txt.text = "flkjdsflkjdsflj fsjdl"
        return txt
    }();
    
    var buubleView:UIView = {
        let view = UIView();
        view.backgroundColor = UIColor(white: 0.95, alpha: 1);
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true;
        return view;
    }();
    
    var userImg:UIImageView = {
        
        let img = UIImageView()
        img.backgroundColor = UIColor.red;
        img.layer.cornerRadius = 15;
        img.layer.masksToBounds = true;
        return img;
        
    }();
    
    
    func setupView()  {
        
        addSubview(buubleView);
        addSubview(textView);
        addSubview(userImg)
        self.textView.backgroundColor = UIColor.clear
        
        // constraint on text view
        
       // textView.translatesAutoresizingMaskIntoConstraints = false;
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: [], metrics: nil, views: ["v0" : textView]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: ["v0" : textView]))
        
        userImg.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(30)]", options: [], metrics: nil, views: ["v0" : userImg]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]-8-|", options: [], metrics: nil, views: ["v0":userImg]));
        
        self .layoutIfNeeded();
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setupView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
