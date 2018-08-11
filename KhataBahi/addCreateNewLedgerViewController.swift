//
//  addCreateNewLedgerViewController.swift
//  KhataBahi
//
//  Created by Apple on 28/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class addCreateNewLedgerViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate,UIGestureRecognizerDelegate{
    var creditAndDebit=["Cr","Dr"]
    var billByBill=["NO","YES"]
    var gropLedgerList=[String]()
    var gropLedgerListSNO=[String]()
    var db_name=String()
    var companyNameText=String()
    var groupResult=String()
    var billByBillStatus=String()
    var creditAndDebitStatus=String()
    var groupLedgerSNOValue=String()
    var createGroupLedgerresult=String()
    var createGroupLedgerFinalResult=String()
    var serverurl=String()
    var enterAmountStatus=String()
    var FnYear=String()
    var paymentCondition=Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let tapGR1 = UITapGestureRecognizer(target: self, action: #selector(CreateNewLedgerViewController.handleTap1(_:)))
         tapGR1.delegate = self
         tapGR1.numberOfTapsRequired = 1
         tapView.addGestureRecognizer(tapGR1)*/
        ledgerName.delegate=self
        enterAmount.delegate=self
        subView.clipsToBounds=true
        subView.layer.cornerRadius=10
        groupView.clipsToBounds=true
        groupView.layer.cornerRadius=8
        groupButton.clipsToBounds=true
        groupButton.layer.cornerRadius=8
        billbybillView.clipsToBounds=true
        billbybillView.layer.cornerRadius=8
        billbybillButton.clipsToBounds=true
        billbybillButton.layer.cornerRadius=8
        BillByBillTableView.delegate=self
        BillByBillTableView.dataSource=self
        crTableView.delegate=self
        crTableView.dataSource=self
        crTableView.isHidden=true
        BillByBillTableView.isHidden=true
        groupLedgerTableview.delegate=self
        groupLedgerTableview.dataSource=self
        groupLedgerTableview.isHidden=true
        
        serverurl=UserDefaults.standard.object(forKey: "server_url") as! String
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
        companyNameText=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        FnYear=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        abc()
    }
    override func viewWillAppear(_ animated: Bool) {
        paymentCondition=UserDefaults.standard.object(forKey: "CashPaymentCondition") as! Int
    }
    @objc func handleTap1(_ gesture: UITapGestureRecognizer){
        
        groupLedgerTableview.isHidden=true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBOutlet weak var groupLedgerLabel: UILabel!
    
    
    @IBOutlet weak var tapView: UIView!
    
    
    @IBOutlet weak var BillByBillTableView: UITableView!
    @IBOutlet weak var crTableView: UITableView!
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var billbybillButton: UIButton!
    @IBOutlet weak var billbybillView: UIView!
    @IBOutlet weak var ledgerName: UITextField!
    
    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var enterAmount: UITextField!
    
    @IBOutlet weak var groupLedgerTableview: UITableView!
    
    @IBOutlet weak var amount: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ledgerName.resignFirstResponder()
        enterAmount.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var a=Int()
        if tableView==crTableView
        {
            a=creditAndDebit.count
            
        }
        else if tableView==BillByBillTableView
        {
            a=billByBill.count
        }
        else if tableView==groupLedgerTableview
        {
            a=gropLedgerList.count
        }
        return a
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        if tableView==crTableView
        {
            cell=crTableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=creditAndDebit[indexPath.row]
            
        }
        else if tableView==BillByBillTableView
        {
            cell=BillByBillTableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=billByBill[indexPath.row]
        }
        else if tableView==groupLedgerTableview
        {
            cell=groupLedgerTableview.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=gropLedgerList[indexPath.row]
        }
        return cell
    }
    
    @IBAction func biilByBillButtonClicked(_ sender: UIButton) {
        if BillByBillTableView.isHidden==true
        {
            BillByBillTableView.isHidden=false
            
        }
        else
        {
            BillByBillTableView.isHidden=true
        }
    }
    
    @IBAction func creditButtonClicked(_ sender: UIButton) {
        if crTableView.isHidden==true
        {
            crTableView.isHidden=false
            
        }
        else
        {
            crTableView.isHidden=true
        }
    }
    
    
    @IBAction func groupListShow(_ sender: UIButton) {
        
        if groupLedgerTableview.isHidden==true
        {
            groupLedgerTableview.isHidden=false
        }
        else
        {
            groupLedgerTableview.isHidden=true
        }
        
    }
    
    @IBOutlet weak var creditButton: UIButton!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView==BillByBillTableView
        {
            billbybillButton.setTitle(billByBill[indexPath.row], for: .normal)
            BillByBillTableView.isHidden=true
        }
        else if tableView==crTableView
        {
            creditButton.setTitle(creditAndDebit[indexPath.row], for: .normal)
            crTableView.isHidden=true
        }
        else if tableView==groupLedgerTableview
        {
            groupButton.setTitle(gropLedgerList[indexPath.row], for: .normal)
            groupLedgerSNOValue=gropLedgerListSNO[indexPath.row]
            groupLedgerTableview.isHidden=true
        }
    }
    func abc()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLedgerGroup xmlns=\"http://tempuri.org/\"><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetLedgerGroup></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"06/06/18")
        let is_URL: String = serverurl+"WSKhataBahiOnline.asmx"
        //let is_URL: String = "http://wservice.senoverp.com/WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverurl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetLedgerGroup", forHTTPHeaderField: "SOAPAction")
        
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
            DispatchQueue.main.sync {
                if self.groupResult != nil
                {
                    let dummyArray:[String]=self.groupResult.components(separatedBy: "^")
                    for value in dummyArray
                    {
                        let dummyArray2=value.components(separatedBy: "~")
                        if dummyArray2.count==2
                        {self.gropLedgerListSNO.append(dummyArray2[0])
                            self.gropLedgerList.append(dummyArray2[1])
                        }
                    }
                    DispatchQueue.main.async {
                        
                        self.groupLedgerTableview.reloadData()
                    }
                    
                }
            }
            
        })
        
        task.resume()
        
    }
    
    func createNewLedger()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CreateNewLedger xmlns=\"http://tempuri.org/\"><ledger_name>\(ledgerNameText.text!)</ledger_name><ledger_group>\(groupLedgerSNOValue)</ledger_group><BillbyBill>\(billByBillStatus)</BillbyBill><OpnTyp>\(creditAndDebitStatus)</OpnTyp><OpnAmt>\(enterAmountStatus)</OpnAmt><CompanyName>\(companyNameText)</CompanyName><FnYear>\(FnYear)</FnYear><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></CreateNewLedger></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"06/06/18")
        // let is_URL: String = "http://wservice.senoverp.com/WSKhataBahiOnline.asmx"
        let is_URL: String = serverurl+"WSKhataBahiOnline.asmx"
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverurl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        // lobj_Request.addValue("wservice.senoverp.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/CreateNewLedger", forHTTPHeaderField: "SOAPAction")
        
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
                if self.createGroupLedgerFinalResult != nil
                {
                    print(self.createGroupLedgerFinalResult,"createGroupLedgerFinalResult")
                    if self.createGroupLedgerFinalResult=="0"
                    { let alert=UIAlertController(title: "Alert", message: "Ledger Not Created Please try Again later", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else if self.createGroupLedgerFinalResult=="2"
                    { let alert=UIAlertController(title: "Alert", message: "Ledger Name Already available", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else if self.createGroupLedgerFinalResult=="3"
                    { let alert=UIAlertController(title: "Alert", message: "Check the Security Key", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        
                        UserDefaults.standard.set(self.ledgerNameText.text!, forKey: "toValue")
                        if self.creditAndDebitStatus=="Cr"
                        {
                            UserDefaults.standard.set(self.enterAmountStatus+"Cr", forKey: "toAmount")
                        }
                        else
                        {
                            UserDefaults.standard.set(self.enterAmountStatus+"Dr", forKey: "toAmount")
                        }
                        UserDefaults.standard.set(self.createGroupLedgerFinalResult, forKey: "ToID")
                        
                        let alert=UIAlertController(title: "Alert", message: "New Ledger Created Succesfully", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: { (ACTION) in
                            
                            if self.paymentCondition==0
                            {
                                // dismiss(animated: true, completion: nil)
                                let st=UIStoryboard(name: "Main", bundle: nil)
                                let vc=st.instantiateViewController(withIdentifier: "cashPayment") as! UIViewController
                                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                            }
                            else if self.paymentCondition==1
                            {
                                let st=UIStoryboard(name: "Main", bundle: nil)
                                let vc=st.instantiateViewController(withIdentifier: "cashReceipt") as! UIViewController
                                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                            }
                            else if self.paymentCondition==2
                            {
                                let st=UIStoryboard(name: "Main", bundle: nil)
                                let vc=st.instantiateViewController(withIdentifier: "Bank Statement") as! UIViewController
                                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                            }
                            else if self.paymentCondition==3
                            {
                                let st=UIStoryboard(name: "Main", bundle: nil)
                                let vc=st.instantiateViewController(withIdentifier: "Bank Receive") as! UIViewController
                                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                            }
                            else{
                                
                            }
                        })
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
            }
            
            
            
            
            
            
            
            
        })
        
        task.resume()
        
    }
    
    @IBOutlet weak var ledgerNameText: UITextField!
    
    var selection=0
    var elementValue: String?
    
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetLedgerGroupResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "CreateNewLedgerResult" {
            createGroupLedgerresult = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil &&  selection==0{
            elementValue! += string
            groupResult=elementValue!
            
            
            
        }
        if createGroupLedgerresult != nil &&  selection==1{
            createGroupLedgerresult += string
            
            
            createGroupLedgerFinalResult=createGroupLedgerresult
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetLedgerGroupResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "CreateNewLedgerResult" {
            createGroupLedgerresult = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    @IBAction func createNewLedger(_ sender: Any) {
        print(billbybillButton.titleLabel!.text,"billbybillButton.titleLabel!.text")
        if billbybillButton.titleLabel!.text=="NO"
        {
            billByBillStatus="No"
        }
        else
        {
            billByBillStatus="Yes"
        }
        
        if creditButton.titleLabel!.text=="  Cr"
        {
            creditAndDebitStatus="Cr"
        }
        else
        {
            creditAndDebitStatus="Dr"
        }
        if ledgerNameText.text?.isEmpty==true
        {
            let alert=UIAlertController(title: "Alert", message: "Enter the Ledger name", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if groupButton.titleLabel?.text?.isEmpty==true
        {
            let alert=UIAlertController(title: "Alert", message: "Select Group Name", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if enterAmount.text?.isEmpty==true
        {
            creditAndDebitStatus=""
            enterAmountStatus="0"
            createNewLedger()
        }
        else
        {
            enterAmountStatus=enterAmount.text!
            createNewLedger()
            
        }
    }
    
}
