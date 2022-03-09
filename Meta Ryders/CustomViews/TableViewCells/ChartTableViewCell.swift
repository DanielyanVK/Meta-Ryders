//
//  GraphTableViewCell.swift
//  Meta Ryders
//
//  Created by Vladislav on 09.03.2022.
//

import UIKit
import Charts

class ChartTableViewCell: UITableViewCell {

    private lazy var lineChartView: LineChartView = {
        let lineChartView = LineChartView()
        return lineChartView
    }()
    
    private let activeOffersLabel: UILabel = {
        let activeOffersLabel = UILabel()
        
        return activeOffersLabel
    }()
    
    private var chartValues: [ChartDataEntry] = []
    private var xAxisValues: [String] = ["9:00", "12:00", "13:00", "15:00", "18:00", "20:00", "22:00"]
    private let browseListingsButton = UIButton(frame: .zero)

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        sendSubviewToBack(contentView)
        selectionStyle = .none
        backgroundColor = .black

        addLineChartView()
        addBrowseListingsButton()
        addActiveOffersLabel()
    }
    
    func updateChart(with chartValues: [ChartDataEntry]) {
        self.chartValues = chartValues
        let valuesSet = LineChartDataSet(entries: chartValues)
        let lineChartData = LineChartData(dataSet: valuesSet)
        lineChartView.data = lineChartData
        
        valuesSet.drawCirclesEnabled = false
        valuesSet.mode = .cubicBezier
        valuesSet.setColor(.graphLineColor)
        valuesSet.highlightColor = .graphLineColor
        valuesSet.drawHorizontalHighlightIndicatorEnabled = false
        lineChartData.setDrawValues(false)
    }
    
    private func addLineChartView() {
        addSubview(lineChartView)
        
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelFont = .standart(ofSize: 12, weight: .regular)
        lineChartView.xAxis.labelTextColor = .lightGray
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        // here we can set any value for xAxis
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValues)
        
        lineChartView.legend.enabled = false
        lineChartView.animate(xAxisDuration: 1.0)
        
        lineChartView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
    }
    
    private func addBrowseListingsButton() {
        addSubview(browseListingsButton)

        browseListingsButton.setImage(UIImage(named: "browseListingsButton"), for: .normal)
        browseListingsButton.addTarget(self, action: #selector(browseListingsButtonTapped), for: .touchUpInside)
        browseListingsButton.snp.makeConstraints { make in
            
            make.leading.equalTo(52)
            make.trailing.equalTo(-52)
            make.top.equalTo(lineChartView.snp.bottom).offset(36)
            make.bottom.equalTo(-36)
        }
    }
    
    private func addActiveOffersLabel() {
        addSubview(activeOffersLabel)
        
        activeOffersLabel.font = .standart(ofSize: 10, weight: .regular)
        activeOffersLabel.textColor = .lightGray
        activeOffersLabel.text = "45 active offers"
        
        activeOffersLabel.snp.makeConstraints { make in
            make.top.equalTo(browseListingsButton.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func browseListingsButtonTapped() {
        print("Browse Listings Button - Tapped")
    }
}

