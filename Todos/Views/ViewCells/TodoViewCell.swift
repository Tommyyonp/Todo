//
//  TodoViewCell.swift
//  Todo App
//
//  Created by Tommy Yon Prakoso on 10/05/22.
//

import UIKit

class TodoViewCell: UITableViewCell {

    static let id = "TodoViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var data : Todo? {
        didSet {
            self.configureCell(with: data)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(with data : Todo?) {
        guard let data = data else { return }
        titleLabel.text = data.title
        contentLabel.text = data.content
        
        self.accessoryType = data.isDone ? .checkmark : .none
    }
    
    class func nib() -> UINib {
        UINib(nibName: "TodoViewCell", bundle: nil)
    }
}
