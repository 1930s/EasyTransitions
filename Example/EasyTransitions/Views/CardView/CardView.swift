//
//  CardView.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

public final class CardView: UIView, NibOwnerLoadable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var iconTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewAspectRatio: NSLayoutConstraint!
    
    // Delegate
    weak var delegate: CardViewDelegate?
    
    // MARK: - Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        set(title: "APP OF THE DAY")
        set(layout: .collapsed)
    }

    private func set(title: String) {
        let attributedString = NSMutableAttributedString(string: title)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        titleLabel.attributedText = attributedString
    }
    
    public func set(layout: CardViewLayout) {
        imageView.layer.cornerRadius = layout.cornerRadius
        iconTopLayoutConstraint.constant = layout.topOffset
        imageViewAspectRatio = imageViewAspectRatio.setMultiplier(multiplier: layout.aspectRatio)
        closeButton.alpha = layout.closeButtonAlpha
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        delegate?.closeCardView()
    }
}
