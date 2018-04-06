//
//  ViewController.swift
//  Bitsygram
//
//  Created by tbredemeier on 4/6/18.
//  Copyright © 2018 tbredemeier. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    var fileURL: URL?
    var images = [Data]() {
        didSet {
            writeToFile()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsURL = paths[0]
        fileURL = documentsURL.appendingPathComponent("Images")
        readFromFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true)
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.images.append(UIImagePNGRepresentation(selectedImage)!)
            collectionView?.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func writeToFile() {
        do {
            let data = try PropertyListEncoder().encode(images)
            try data.write(to: fileURL!)
            print("Successful writeToFile")
        }
        catch {
            print("Failed writeToFile")
        }
    }

    func readFromFile() {
        do {
            let data = try Data(contentsOf: fileURL!)
            let images = try PropertyListDecoder().decode([Data].self, from: data)
            self.images = images
            print("Successful readFromFile")
        }
        catch {
            print("Failed readFromFile")
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(data: images[indexPath.item])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let image = images.remove(at: sourceIndexPath.item)
        images.insert(image, at: destinationIndexPath.item)
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Image Options", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.images.remove(at: indexPath.item)
            collectionView.reloadData()
        }
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }

    @IBAction func onLibraryButtonTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

