//
//  SearcgViewCellTableViewCell.swift
//  CampApp
//
//  Created by Nurullah Vural on 10.03.2022.
//

import UIKit
import Common
import SnapKit

public class SearchViewCell: UITableViewCell {
    static let identifier = String(describing: SearchViewCell.self)
    
    private let label : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = FontProvider.segmentRegular
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(_ text: String?)  {
        self.label.text = text ?? ""
        self.backgroundColor = .secondarySystemBackground
    }
    private func setupConstraints () {
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(44)
            $0.bottom.equalToSuperview()
        }
    }
}
