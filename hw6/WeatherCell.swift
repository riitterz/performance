//
//  WeatherCell.swift
//  performance-1788
//
//  Created by Macbook on 03.03.2022.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var weather: UILabel! {
        didSet {
            weather.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var time: UILabel! {
        didSet {
            time.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            icon.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    let instets: CGFloat = 10.0
    
    func setWeather(text: String) {
        weather.text = text
        weaterLabelFrame()
    }
    
    func setTime(text: String) {
        time.text = text
        timeLabelFrame()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        weaterLabelFrame()
        
        timeLabelFrame()
        
        iconFrame()
    }
    
    func getLabelSize(text: String, font: UIFont) -> CGSize {
        // определяем максимальную ширину текста: ширина ячейки минус отступы слева и справа
        let maxWidth = bounds.width - instets * 2
        // получаем размеры блока под надпись
        // используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        // получаем прямоугольник под текст в этом блоке и уточняем шрифт
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        // получаем ширину блока, переводим ее в Double
        let width = Double(rect.size.width)
        // получаем высоту блока, переводим ее в Double
        let height = Double(rect.size.height)
        // получаем размер
     //   let size = CGSize(width: width, height: height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    func weaterLabelFrame() {
        //получаем размер текста, передавая сам текст и шрифт.
        let weaterLabelSize = getLabelSize(text: weather.text!, font: weather.font)
        //рассчитывает координату по оси Х
        let weaterLabelX = (bounds.width - weaterLabelSize.width) / 2
        //получим точку верхнего левого угла надписи
        let weaterLabelOrigin =  CGPoint(x: weaterLabelX, y: instets)
        //получаем фрейм и устанавливаем UILabel
        weather.frame = CGRect(origin: weaterLabelOrigin, size: weaterLabelSize)
    }
    
    func timeLabelFrame() {
        //получаем размер текста, передавая сам текст и шрифт.
        let timeLabelSize = getLabelSize(text: time.text!, font: time.font)
        //рассчитывает координату по оси Х
        let timeLabelX = (bounds.width - timeLabelSize.width) / 2
        //рассчитывает координату по оси Y
        let timeLabelY = bounds.height - timeLabelSize.height - instets
        //получим точку верхнего левого угла надписи
        let timeLabelOrigin =  CGPoint(x: timeLabelX, y: timeLabelY)
        //получаем фрейм и устанавливаем UILabel
        time.frame = CGRect(origin: timeLabelOrigin, size: timeLabelSize)
    }
    
    func iconFrame() {
        let iconSideLinght: CGFloat = 50
        let iconSize = CGSize(width: iconSideLinght, height: iconSideLinght)
        let iconOrigin = CGPoint(x: bounds.midX - iconSideLinght / 2, y: bounds.midY - iconSideLinght / 2)
        icon.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
    
    
}

