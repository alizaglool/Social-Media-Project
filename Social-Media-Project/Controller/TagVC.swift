//
//  TagVC.swift
//  Social-Media-Project
//
//  Created by Zaghloul on 12/09/2022.
//

import UIKit

class TagVC: UIViewController {

    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    
    var tags: [String] = ["",
                          " !2!11", " #hello", " #rami"," #reda"," bone hands"," daytime", " dog"," edit"," hello world",
                          " hi"," nature"," new"," prijatno"," random"," ruzno"," scarry", " sea"," tree"," winter"," women",
                          "!@","\"blqqq\"","#API","#Thala #MSD #CaptailnCool","#photo","#road","#tag1","#tag1,#tag2","#tag2",
                          "#tag3","-1","..mlmdas", ".net", "/*-","0","0000","00000", "00000000", "0309-1","0309-2","1", "10",
                          "10785 berlin", "108", "1080p", "11","1111","115","12", "123","123098","1234","12345","1234566","1234567",
                          "123456789","126","131","132","134", "1351","137","14","142","155","172","177","19","196","198","1йq!"
                          ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
//        PostAPI.getAllTags { tags in
//            self.tags = tags
//            self.tagCollectionView.reloadData()
//        }
    }
    


}

extension TagVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        //let tag = tags[indexPath.row]
        cell.tagName.text = tags[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let seletedItem = tags[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostVC
        vc.tag = seletedItem
        self.present(vc, animated: true, completion: nil)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width * 0.33 , height: collectionView.frame.width * 0.3)
//    }
    
    
}
