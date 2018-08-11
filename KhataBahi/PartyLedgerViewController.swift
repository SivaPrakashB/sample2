//
//  PartyLedgerViewController.swift
//  KhataBahi
//
//  Created by Narayan on 6/11/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class PartyLedgerViewController:  UIViewController,UITextFieldDelegate,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableViewAppearView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var companyname: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var fnYear: UILabel!
    var imageView:UIImageView!
    @IBOutlet weak var companyName1: UILabel!
    var pdf123=String()
    var a=0
    var picker=UIDatePicker()
    var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
    var fnYear1=String()
    var dashBoardCompanyName123=String()
    var db_name=String()
    var server_url=String()
    var selection=0
    var startDate=String()
    var endDate=String()
    var GetStartEndDteOfFnYearResult=String()
    
    
    var cashId=[String]()
    var cashNames=[String]()
    var cashAmounts=[String]()
    var cashStatus=[String]()
    var searchResults=[String]()
    var GetLedgersCASHResult=String()
    var CashIDString=String()
    var CashNameString=String()
    var lastYear123=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        self.view.isUserInteractionEnabled=false
        searchTextField.delegate=self
        tableViewAppearView.isHidden=true
         searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tableView.separatorStyle = .none
        //shadowView.layer.shadowColor=UIColor.black.cgColor
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowRadius = 8
        shadowView.layer.shouldRasterize = true
        
       shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
    }
    
    
    @IBOutlet weak var shadowView: UIView!
    
  
    override func viewDidAppear(_ animated: Bool) {
        
       fnYear1=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
       dashBoardCompanyName123=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        server_url=UserDefaults.standard.object(forKey: "server_url") as! String
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
     
        
        companyName1.text=dashBoardCompanyName123
        fnYear.text="(\(fnYear1))"
        
        
        createDatePicker()
        createDatePicker1()
        abc1()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBOutlet weak var dismiss: UIButton!
    
    @IBAction func dismissView(_ sender: UIButton) {
      
        dismiss(animated: false, completion: nil)
    }
    func createDatePicker()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar11.setItems([done], animated: false)
        
        fromTextField.inputAccessoryView=toolBar11
        fromTextField.inputView=picker
        picker.datePickerMode = .date
        
    }
    @objc func donePressed()
    {
        
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
        //  dateForServer=formatter1.string(from: picker.date)
        //
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
        fromTextField.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    func createDatePicker1()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolBar11.setItems([done], animated: false)
        
        toTextField.inputAccessoryView=toolBar11
        toTextField.inputView=picker
        picker.datePickerMode = .date
        
    }
    @objc func donePressed1()
    {
        
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
        //  dateForServer=formatter1.string(from: picker.date)
        //
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
        toTextField.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.resignFirstResponder()
        return true
    }
    func abc1()
    {selection=0
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetStartEndDteOfFnYear xmlns=\"http://tempuri.org/\"><FnYear>\(fnYear1)</FnYear><CompanyName>\(dashBoardCompanyName123)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetStartEndDteOfFnYear></soap:Body></soap:Envelope>"
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetStartEndDteOfFnYear", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            //XMLparser.shouldResolveExternalEntities = true
            if data != nil
            {
                DispatchQueue.main.async {
                    print(self.GetStartEndDteOfFnYearResult,"11/06/18")
                    var dummy:[String]=self.GetStartEndDteOfFnYearResult.components(separatedBy: "^")
                    if dummy.count==2
                    {
                        self.startDate=dummy[0]
                        self.endDate=dummy[1]
                        self.fromTextField.text=dummy[0]
                        self.toTextField.text=dummy[1]
                        self.selection=1
                        self.GetLedgersCASH()
                    }
                    
                }
            }
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
        
    }
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetStartEndDteOfFnYearResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "GetLedgersOTHERResult" {
            elementValue = String()
           selection=1
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection==0{
            elementValue! += string
            
            GetStartEndDteOfFnYearResult=elementValue!
            
        }
        if elementValue != nil && selection==1{
            elementValue! += string
            
           GetLedgersCASHResult=elementValue!
            
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetStartEndDteOfFnYearResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "GetLedgersOTHERResult" {
            elementValue = String()
         selection=1
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    func GetLedgersCASH()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLedgersOTHER xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName123)</CompanyName><DB>\(db_name)</DB><FnYear>\(fnYear1)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetLedgersOTHER></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"getGraphdataBvsp")
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetLedgersOTHER", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            
            //XMLparser.shouldResolveExternalEntities = true
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            DispatchQueue.main.async {
                
                var dummyList=self.GetLedgersCASHResult.components(separatedBy:"^")
                for value in dummyList
                {
                    var dummySecondList=value.components(separatedBy: "~")
                    if dummySecondList.count == 4
                    {
                        self.cashId.append(dummySecondList[0])
                        self.cashNames.append(dummySecondList[1])
                        if dummyList[2]==""
                        {
                            self.cashAmounts.append("0.00")
                        }
                        else
                        {
                            self.cashAmounts.append(dummySecondList[2])
                        }
                        self.cashStatus.append(dummySecondList[3])
                    }
                }
                self.imageView.isHidden=true
                self.view.isUserInteractionEnabled=true
               // self.searchTextField.becomeFirstResponder()
                self.searchResults=self.cashNames
                //self.tableViewAppearView.isHidden=false
                self.tableView.reloadData()
            }
        })
        task.resume()
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        searchResults=cashNames
        tableView.reloadData()
        tableViewAppearView.isHidden=false
        
        
        return true
    }
    /* func textFieldDidBeginEditing(_ textField: UITextField) {
     searchResults=names
     tableView.isHidden=false
     tableView.reloadData()
     }*/
    
    
    @objc func textFieldDidChange(_:UITextField){
        
        
        // print(customername.text!)
        
        
        // tableView.isHidden=false
        searchResults=[]
        
        
        searchResults = cashNames.filter({(coisas1:String) -> Bool in
            if (coisas1.lowercased()).contains(searchTextField.text!) || (coisas1.contains(searchTextField.text!))
            {
                return true
            }
            else
            {
                
                return false
            }
            
            
        })
       
        if searchTextField.text! == nil || searchTextField.text! == "" || searchTextField.text!.isEmpty==true
        {
            searchResults=cashNames
            tableView.reloadData()
        }
        else
        {
            tableView.reloadData()
            tableViewAppearView.isHidden=false
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=searchResults[indexPath.row]
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=tableView.cellForRow(at: indexPath) as! UITableViewCell
        let label:String=(cell.textLabel?.text)!
        UserDefaults.standard.set(label, forKey: "toValue")
        for i in 0..<cashNames.count
        {
            if cashNames[i] == label
            {self.searchTextField.text=self.cashNames[i]
                self.tableViewAppearView.isHidden=true
                self.CashIDString=self.cashId[i]
                self.CashNameString=self.cashNames[i]
                

                /*UserDefaults.standard.set(self.cashAmounts[i], forKey: "toAmount")
                UserDefaults.standard.set(self.cashId[i], forKey: "ToID")*/
            }
        }
        //UserDefaults.standard.set(self.cashAmounts[indexPath.row], forKey: "toAmount")
       /* let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "cashPayment") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)*/
    }
    
   
    @IBAction func searchAction(_ sender: UIButton) {
        let dateforNextPage="\(startDate) to \(endDate)"
        let Info:String="\(CashNameString),\(CashIDString),\(startDate),\(endDate)"
        print(Info,"12/08/19")
        UserDefaults.standard.set(Info, forKey: "Info")
        let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "PartyLedgerShow") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
}

