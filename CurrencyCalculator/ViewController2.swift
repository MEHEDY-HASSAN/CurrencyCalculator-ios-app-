//
//  ViewController2.swift
//  CalculatorTutorial
//
//  Created by Tashin Ahamed on 12/24/22.
//

import UIKit

class ViewController2: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pick1 : String?
    var pick2 : String?
    
    var country1 = [""]
    var country2 = [""]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            // test
//            outputres.text = country1[row]
            return "\(self.country1[row])"
        }
        else{
            //outputres = country2[row]
            return "\(self.country2[row])"
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.country1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Picker piceker   ",pickerView.tag)
        if pickerView.tag == 1{
            self.pick1 = self.country1[row]
            // test
//            outputres.text = country1[row]
        }
        else{
            self.pick2 = self.country2[row]
            // test
//            outputres.text = country2[row]
        }
    }
    
    @IBOutlet weak var inputfld: UITextField!
    @IBOutlet weak var outputres: UILabel!
    
    @IBOutlet weak var pickerview1: UIPickerView!
    
    @IBOutlet weak var pickerview2: UIPickerView!
    
    
    @IBOutlet weak var btcPrice: UILabel!
    
    @IBOutlet weak var ethPrice: UILabel!
    
    @IBOutlet weak var usdPrice: UILabel!
    
    @IBOutlet weak var audPrice: UILabel!
    @IBOutlet weak var lastUpdatedPrice: UILabel!
    
    @IBOutlet weak var banPrice: UILabel!
    let urlString = "https://api.coingecko.com/api/v3/exchange_rates"
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        fetchData()
        
        country1 = ["Select Currency","Bitcoin","Etherium","US Dollar","Australian Dollar","Bangladeshi Taka","Indian Rupee","Sri Lankan Rupee"]
        country2 = ["Select Currency","Bitcoin","Etherium","US Dollar","Australian Dollar","Bangladeshi Taka","Indian Rupee","Sri Lankan Rupee"]
        
        _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    var values = [0.0,0.0,0.0,0.0,0.0,0.0,0,0]
    // Converter Button
    @IBAction func converterbtn(_ sender: Any) {
//        showAlert()
//        if let text = inputfld.text, text.isEmpty {
//            print(text)
//            let alertt = UIAlertController(title: "Alert", message: "Please Enter a Numeric", preferredStyle: .alert)
//            alertt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        } else {
//           // myTextField is Empty
//        }
        let tmptext = inputfld.text
        var tobitcoin = Double(tmptext!)
        var v2 = 5.5
        if(self.pick1 == "Select Currency")
        {
//            showAlert()
//            return
        }
        else if(self.pick1 == "Bitcoin"){
            v2 = self.values[0]
        }
        else if(self.pick1 == "Etherium"){
            v2 = self.values[1]
        }
        else if(self.pick1 == "US Dollar"){
            v2 = self.values[2]
        }
        else if(self.pick1 == "Australian Dollar"){
            v2 = self.values[3]
        }
        else if(self.pick1 == "Bangladeshi Taka"){
            v2 = self.values[4]
        }
        else if(self.pick1 == "Indian Rupee"){
            v2 = self.values[5]
        }
        else if(self.pick1 == "Sri Lankan Rupee"){
            v2 = self.values[6]
        }
        tobitcoin = tobitcoin!/v2
        
//        print("first ta " , v2,tobitcoin, self.pick1)
        var v1 = 0.0
        if(self.pick2 == "Select Currency")
        {
//            showAlert()
//            return
        }
        else if(self.pick2 == "Bitcoin"){
            v1 = self.values[0]
        }
        else if(self.pick2 == "Etherium"){
            v1 = self.values[1]
        }
        else if(self.pick2 == "US Dollar"){
            v1 = self.values[2]
        }
        else if(self.pick2 == "Australian Dollar"){
            v1 = self.values[3]
        }
        else if(self.pick2 == "Bangladeshi Taka"){
            v1 = self.values[4]
        }
        else if(self.pick2 == "Indian Rupee"){
            v1 = self.values[5]
        }
        else if(self.pick2 == "Sri Lankan Rupee"){
            v1 = self.values[6]
        }
//        print(v1)
        var res = 0.0
        res = v1 * tobitcoin!
//        res = res / 100000000.0
//        print(res)
//        print("second ta ",v1,res,self.pick2)
        self.outputres.text = String(res)
        
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Invalid", message: "Please select any currency", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: {
            action in print("okay pressed")
        }))
        present(alert,animated: true)
    }
    
    @objc func refreshData() -> Void
    {
        fetchData()
    }
    
    func fetchData()
    {
        let url = URL(string: urlString)
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url!) {
            (data: Data?, response: URLResponse?,error: Error?) in
            
            if(error != nil)
            {
                print(error!)
                return
            }
            
            do
            {
                let json = try JSONDecoder().decode(Rates.self, from: data!)
                self.setPrices(currency: json.rates)
            }
            catch
            {
                print(error)
                return
            }
            
            
        }
        dataTask.resume()
    }
    func setPrices(currency: Currency)
    {
        DispatchQueue.main.async
        {
            self.values[0] = Double(currency.btc.value)
            self.values[1] = Double(currency.eth.value)
            self.values[2] = Double(currency.usd.value)
            self.values[3] = Double(currency.aud.value)
            self.values[4] = Double(currency.bdt.value)
            self.values[5] = Double(currency.inr.value)
            self.values[6] = Double(currency.lkr.value)
            print(self.values)
//            self.btcPrice.text = self.formatPrice(currency.btc)
//            self.ethPrice.text = self.formatPrice(currency.eth)
//            self.usdPrice.text = self.formatPrice(currency.usd)
//            self.audPrice.text = self.formatPrice(currency.aud)
//            self.banPrice.text = self.formatPrice(currency.bdt)
//            self.lastUpdatedPrice.text = self.formatDate(date: Date())
        }
    }
    
    func formatPrice(_ price: Price) -> String
    {
        return String(format: "%@ %.6f", price.unit, price.value)
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM y HH:mm:ss"
        return formatter.string(from: date)
    }

    struct Rates: Codable
    {
        let rates: Currency
    }
    
    struct Currency: Codable
    {
        let btc: Price
        let eth: Price
        let usd: Price
        let aud: Price
        let bdt: Price
        let inr: Price
        let lkr: Price
    }
    
    struct Price: Codable
    {
        let name: String
        let unit: String
        let value: Float
        let type: String
    }
    
}

//{
//   "rates":{
//      "btc":{
//         "name":"Bitcoin",
//         "unit":"BTC",
//         "value":1.0,
//         "type":"crypto"
//      },
//      "eth":{
//         "name":"Ether",
//         "unit":"ETH",
//         "value":14.504,
//         "type":"crypto"
//      },
//      "usd":{
//         "name":"US Dollar",
//         "unit":"$",
//         "value":40411.784,
//         "type":"fiat"
//      },
//      "aud":{
//         "name":"Australian Dollar",
//         "unit":"A$",
//         "value":54744.592,
//         "type":"fiat"
//      },
//   }
//}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
