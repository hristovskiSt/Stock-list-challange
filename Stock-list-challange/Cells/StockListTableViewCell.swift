//
//  StockListTableViewCell.swift
//  Stock-list-challange
//
//  Created by Stefan Hristovski on 29.1.22.
//

import UIKit
import Foundation

class StockListTableViewCell: UITableViewCell {
    
    static let identifier = "StockListTableViewCell"

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(stocks:Stocks){
      
        companyNameLabel.text = stocks.companyName
        priceLabel.text = String(stocks.price!)
        marketCapLabel.text = "Market cap \(stocks.marketCap!)"
    }
    
}
