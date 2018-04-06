//
//  CollectionViewCell.swift
//  Bitsygram
//
//  Created by tbredemeier on 4/6/18.
//  Copyright © 2018 tbredemeier. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!

    @IBAction func onLikeButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.setImage(UIImage(named: "Like"), for: .normal)
            sender.tag = 1
        }
        else {
            sender.setImage(UIImage(named: "UnLike"), for: .normal)
            sender.tag = 0
        }
    }
}
