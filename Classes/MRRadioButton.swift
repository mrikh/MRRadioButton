//
//  MRRadioButton.swift
//  RadioButtonExample
//
//  Created by Mayank Rikh on 19/02/19.
//  Copyright © 2019 Mayank Rikh. All rights reserved.
//

import UIKit

open class MRRadioButton : UIButton{

    /// read only property for current state
    private (set) open var currentlySelected : Bool = false

    /// Main color to use while filling in background
    @IBInspectable var backgroundFillColor : UIColor = UIColor.black{
        didSet{
            selectionView.backgroundColor = backgroundFillColor
            fadingView.backgroundColor = backgroundFillColor
        }
    }

    /// Border of the view to set
    @IBInspectable var borderColor : UIColor = UIColor.black{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }

    /// Border width to set
    @IBInspectable var borderWidth : CGFloat = 1.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }

    /// Update the selected state of the button. This overrides the default property
    private var isGrowing : Bool = false
    private var isShrinking : Bool = false
    private var selectionView = UIView()
    private var fadingView = UIView()
    private var minimumTransform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    private var maximumTransform = CGAffineTransform(scaleX: 3.0, y: 3.0)

    override open func awakeFromNib() {

        super.awakeFromNib()
        customInitialization()
    }

    public override init(frame: CGRect) {

        super.init(frame: frame)
        customInitialization()
    }

    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        customInitialization()
    }

    override open func layoutSubviews() {

        super.layoutSubviews()
        selectionView.layer.cornerRadius = selectionView.bounds.width/2.0
        fadingView.layer.cornerRadius = fadingView.bounds.width/2.0
        layer.cornerRadius = layer.bounds.width/2.0
    }

    open func updateSelection(select : Bool, animated : Bool = false){

        //dont update
        if currentlySelected == select {return}

        currentlySelected = select
        currentlySelected ? startSelection(animated : animated) : clearSelection(animated : animated)
    }

    //MARK:- Private
    private func customInitialization(){

        setupView(selectionView)
        setupView(fadingView)

        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }

    private func setupView(_ view : UIView){

        addSubview(view)
        view.backgroundColor = backgroundFillColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false

        var customConstraints = [NSLayoutConstraint]()

        customConstraints.append(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1.0, constant: 0.0))
        customConstraints.append(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        customConstraints.append(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        customConstraints.append(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.65, constant: 0.0))

        addConstraints(customConstraints)
        view.transform = minimumTransform
        view.alpha = 0.0
    }

    private func startSelection(animated : Bool = false){

        if isGrowing {return}

        resetViews()
        isGrowing = true

        UIView.animate(withDuration: animated ? 0.2 : 0.0, delay: 0.0, options: .curveLinear, animations: { [weak self] in

            self?.selectionView.transform = .identity
            self?.selectionView.alpha = 1.0
            self?.fadingView.transform = .identity
            self?.fadingView.alpha = 1.0

        }) { (finished) in

            UIView.animate(withDuration: animated ? 0.4 : 0.0, animations: { [weak self] in
                self?.fadingView.alpha = 0.0
            })

            UIView.animate(withDuration: animated ? 0.5 : 0.0, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in
                self?.fadingView.transform = self?.maximumTransform ?? .identity
            }, completion: { [weak self] (finished) in
                self?.fadingView.transform = self?.minimumTransform ?? .identity
                self?.isGrowing = false
            })
        }
    }

    private func clearSelection(animated : Bool = false){

        if isShrinking {return}
        isShrinking = true

        UIView.animate(withDuration: animated ? 0.25 : 0.0, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in

            self?.selectionView.transform = self?.minimumTransform ?? .identity
            self?.selectionView.alpha = 0.0
        }) { [weak self] (finished) in

            self?.isShrinking = false
            self?.resetViews()
        }
    }

    private func resetViews(){

        selectionView.transform = minimumTransform
        fadingView.transform = minimumTransform
        selectionView.alpha = 0.0
        fadingView.alpha = 0.0
    }
}
