//
//  AlarmTableViewCell.swift
//  done
//
//  Created by yang on 26/3/2023.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    let time = UILabel()
    let label = UILabel()
    let isOn = UISwitch()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        time.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        isOn.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(time)
        time.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        time.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(label)
        label.leftAnchor.constraint(equalTo: time.rightAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(isOn)
        isOn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        isOn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
