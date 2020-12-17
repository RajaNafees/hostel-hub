//
//  ViewController.swift
//  Hostels Hub
//
//  Created by Apple on 14/10/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var hostelmainarr =  [HostelsModel]()
    let Gogplace = Googleplaces()
    // for loader
    var loadingIndicator = UIActivityIndicatorView()
    var loaderLbl = UILabel()
    
    @IBOutlet weak var SearchPlacesTF: UITextField!
    
    @IBOutlet weak var PlacesTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func SearcPlacesBtnAction(_ sender: Any) {
        if SearchPlacesTF.text == "" {
            simpleAlert(title: "info", message: "Please Enter place Name")
        }else {
            startLoader()
            Gogplace.getHostels(placename: SearchPlacesTF.text!) { (issuccess, hostelsarr) in
                if issuccess {
                    self.hostelmainarr = hostelsarr
                    DispatchQueue.main.async {
                        self.stopLoader()
                        self.PlacesTbl.reloadData()
                    }
                   
                }else {
                    self.simpleAlert(title: "info", message: "Network Problem")
                }
            }
        }
        
    }
    func simpleAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    func startLoader() {
        self.view.isUserInteractionEnabled = false
        loadingIndicator.frame = CGRect(x: (self.view.frame.width / 2) - 50, y: (self.view.frame.height / 2) - 25, width: 25, height: 50)
        loadingIndicator.center = self.view.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        
        loaderLbl.frame = CGRect(x: (self.view.frame.width / 2) - 50, y: loadingIndicator.frame.origin.y + loadingIndicator.frame.height + 10, width: 200, height: 50)
        self.view.addSubview(loadingIndicator)
        //        self.view.addSubview(loaderLbl)
    }
    func stopLoader() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
        loaderLbl.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
    
}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostelmainarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placestblCell", for: indexPath) as! placestblCell
        cell.placenamelbl.text = hostelmainarr[indexPath.row].name
        cell.addresslbl.text = hostelmainarr[indexPath.row].address
        cell.distancelbl.text = hostelmainarr[indexPath.row].rating
       
        
        return cell
    }
    
    
}

