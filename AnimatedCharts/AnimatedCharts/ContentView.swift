//
//  ContentView.swift
//  AnimatedCharts
//
//  Created by Jason on 2024/4/9.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    enum ChartStyle: CaseIterable, Identifiable, CustomStringConvertible{
        case bar
        case line
        case sector
        var id: Self { self }

        var description: String {
            switch self {
            case .bar:
                return "Bar"
            case .line:
                return "Line"
            case .sector:
                return "Sector"
            }
        }
    }
    
    /// View's Properties
    @State private var appDownloads: [Download] = sampleDownloads
    @State private var isAnimated: Bool = false
    @State private var trigger: Bool = false
    
    @State private var chartStyle: ChartStyle = .bar
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Picker("Auto-Join Hotspot", selection: $chartStyle) {
                    ForEach(ChartStyle.allCases) { option in
                        Text(String(describing: option))

                    }
                }
                .pickerStyle(.segmented)
                
                Chart {
                    ForEach(appDownloads) { download in
                        if chartStyle == .bar {
                            BarMark(
                               x: .value("Month", download.month),
                               y: .value("Downloads", download.isAnimated ? download.value : 0 )
                            )
                            .foregroundStyle(.red.gradient)
                            .opacity(download.isAnimated ? 1 : 0 )
                        }else if chartStyle == .line {
                            LineMark(
                               x: .value("Month", download.month),
                               y: .value("Downloads", download.isAnimated ? download.value : 0 )
                            )
                            .foregroundStyle(.red.gradient)
                            .opacity(download.isAnimated ? 1 : 0 )
                        }else if chartStyle == .sector{
                            SectorMark(
                               angle: .value("Downloads", download.isAnimated ? download.value : 0 )
                            )
                            .foregroundStyle(by: .value("Month", download.month))
                            .opacity(download.isAnimated ? 1 : 0 )
                        }
                    }
                }
                .chartYScale(domain: 0...12000)
                .frame(height: 250)
                .padding()
                .background(.background, in: .rect(cornerRadius: 10))
                
                Spacer(minLength: 0) 
            }
            .padding()
            .background(.gray.opacity(0.12))
            .navigationTitle("Animated Charts")
            .onAppear(perform: animateChart )
            .onChange(of: trigger) { oldValue, newValue in
                resetChartAnimation()
                animateChart()
            }
            .onChange(of: chartStyle) { oldValue, newValue in
                resetChartAnimation()
                animateChart()
            }
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Trigger") {
                        /// Adding Extra Dummy Data
                        appDownloads.append(contentsOf: [
                            .init(date: .createDate(1, 2, 2024), value: 4700),
                            .init(date: .createDate(1, 3, 2024), value: 9700),
                            .init(date: .createDate(1, 4, 2024), value: 1700)
                        ])
                        trigger.toggle()
                    }
                }
            })
        }
    }
    
    private func animateChart() {
        guard !isAnimated else { return  }
        isAnimated = true
        $appDownloads.enumerated().forEach { index, element in
            if index > 5 {
                element.wrappedValue.isAnimated = true
            }else {
                let delay = Double(index) * 0.05
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.smooth) {
                        element.wrappedValue.isAnimated = true
                    }
                }
            }
        }
    }
    
    private func resetChartAnimation() {
        $appDownloads.forEach { download in
            download.wrappedValue.isAnimated = false
        }
        
        isAnimated = false
    }
}

#Preview {
    ContentView()
}
