//
//  DownloadButton.swift
//  ips_assignment
//
//  Created by Loyd Kim on 2023-02-08.
//

import UIKit

class DownloadButton: UIButton{
    convenience init(target: Any?, selector: Selector) {
        self.init(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        tintColor = buttonColor
        setTitle("  Download", for: .normal)
        setTitleColor(buttonColor, for: .normal)
        addTarget(target, action: selector, for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
