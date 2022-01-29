//
//  ViewController.swift
//  Stock-list-challange
//
//  Created by Stefan Hristovski on 29.1.22.
//

import UIKit

class StockListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tableView: UITableView!
    
    var stocksArray = [Stocks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Stock list"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        getStocks()
        
        tableView.register(UINib(nibName: StockListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: StockListTableViewCell.identifier)
        
        
    }
    
        //MARK: - TableView delegates -

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockListTableViewCell.identifier) as? StockListTableViewCell
        let stocks = stocksArray[indexPath.row]
        cell?.setupCell(stocks: stocks)
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: - API -
    
    func getStocks(){
//        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://financialmodelingprep.com/api/v3/stock-screener?marketCapMoreThan=1000000000&volumeMoreThan=10000&sector=Technology&exchange=NASDAQ&limit=100&apikey=d64d179adb2bcbf73edd76abd7e9e477")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
//            semaphore.signal()
            return
          }
            do{
                let result = try JSONDecoder().decode([Stocks].self, from: data)
                self.stocksArray = result
                print(result)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
                print("Error parsing JSON", error)
            }
            
//          semaphore.signal()
        }

        task.resume()
//        semaphore.wait()
    }
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Order by", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Alphabetical", style: .default, handler: { action in
            //TODO:Add alphabetical order here
        }))
        alert.addAction(UIAlertAction(title: "Market cap", style: .default, handler: { action in
            //TODO:Add market cap order here
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true)
    }
}

