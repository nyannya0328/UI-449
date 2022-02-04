//
//  Home.swift
//  UI-449
//
//  Created by nyannyan0328 on 2022/02/04.
//

import SwiftUI

struct Home: View {
    
    @State var startAngle : Double = 0
    
    @State var totAngle : Double = 180
    
    
    @State var startProgress : CGFloat = 0
    @State var toProgress : CGFloat = 0.5
    var body: some View {
        VStack{
            
            HStack{
                
                
                VStack(alignment: .leading, spacing: 13) {
                    
                    Text("Today")
                        .font(.title.weight(.bold))
                    
                    Text("Good Morning")
                        .font(.callout.weight(.bold))
                        .opacity(0.7)
                    
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                
                Button {
                    
                } label: {
                    
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }

            }
            
            
            
            SleepTimer()
                .padding(.top,50)
            
            
            Button {
                
            } label: {
                
                
                Text("Start Sleep")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Blue"),in: RoundedRectangle(cornerRadius: 10))
                  
                    .padding(.horizontal,25)
            }
            .padding(.top,60)
            
            
            
            HStack{
                
                VStack(spacing:20){
                    
                    
                    Label {
                        
                        Text("Bet Time")
                        
                    } icon: {
                        
                        Image(systemName: "moon.fill")
                            
                        
                    }
                    
                    
                    Text("\(getTime(angle:startAngle).formatted(date: .omitted, time: .shortened))")
                        .font(.largeTitle.weight(.heavy))

                    
                    
                    
                }
                .frame(maxWidth:.infinity)
                
                VStack(spacing:20){
                    
                    
                    Label {
                        
                        Text("Bet Time")
                        
                    } icon: {
                        
                        Image(systemName: "alarm")
                            
                        
                    }
                    
                    
                    Text("\(getTime(angle:totAngle).formatted(date: .omitted, time: .shortened))")
                        .font(.largeTitle.weight(.heavy))

                    
                    
                    
                }
                .frame(maxWidth:.infinity)
                
                
            }
            .padding()
            .background(.gray.opacity(0.1),in: RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal,20)
            .padding(.top,50)

            
            
            
            
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
    }
    @ViewBuilder
    func SleepTimer()->some View{
        
        
        GeometryReader{proxy in
            
            let size = proxy.size.width
            
            ZStack{
                
                
                ZStack{
                    
                    ForEach(1...60,id:\.self){index in
                        
                        
                        Rectangle()
                            .fill(index % 5 == 0 ? .black : .black)
                            .frame(width: 3, height: index % 5 == 0 ? 13 : 5)
                            .offset(y: (size - 60) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 6))
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    let texts = [12,3,6,9]
                    
                    
                    
                    ForEach(texts.indices,id:\.self){index in
                        
                        
                        
                        Text("\(texts[index])")
                            .font(.callout.bold())
                            .rotationEffect(.init(degrees: Double(index) * -90))
                            .offset(y: (size - 90) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 90))
                          
                        
                    }
                    
                    
                    
                }
                
                
                
                
                Circle()
                    .stroke(.black.opacity(0.3),lineWidth: 40)
                
                let reverce = (startProgress > toProgress) ? -Double((1 - startProgress) * 360) : 0
                
                
                Circle()
                    .trim(from: startProgress > toProgress ? 0 : startProgress, to: toProgress + (-reverce / 360))
                    .stroke(Color("Blue"),style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.init(degrees: -90))
                    .rotationEffect(.init(degrees: reverce))
                
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -startAngle))
                    .foregroundColor(Color("Blue"))
                    .background(.white,in: Circle()) .clipShape(Circle())
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(
                    
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value,fromeSlider: true)
                            })
                    
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                
                Image(systemName: "alarm")
                    .font(.callout)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("Blue"))
                    .background(.white,in: Circle()) .clipShape(Circle())
                    .rotationEffect(.init(degrees: 90))
                    .rotationEffect(.init(degrees: -totAngle))
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: totAngle))
                    .gesture(
                    
                        DragGesture()
                            .onChanged({ value in
                                
                                onDrag(value: value)
                                
                            })
                    
                    )
                    .rotationEffect(.init(degrees: -90))
                
                
                
                VStack(spacing:13){
                    Text("\(getTimerDiffrence().0)hour")
                        .font(.largeTitle.weight(.bold))
                        
                    
                    Text("\(getTimerDiffrence().1)min")
                    
                }
                .scaleEffect(1.3)
                    
                
                    
                
                
                
            }
            
            
        }
        .frame(width: getRect().width / 1.6, height: getRect().width / 1.6)
        
    }
    
    func onDrag(value : DragGesture.Value,fromeSlider : Bool = false){
        
        
        
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        let radius = atan2(vector.dy - 15, vector.dx - 15)
        
        
        var angle = radius * 180 / .pi
        
        if angle < 0{angle = 360 + angle}
        
        let progress = angle / 360
        
        if fromeSlider{
            
            
            self.startAngle = angle
            self.startProgress = progress
            
        }
        
        else{
            
            self.totAngle = angle
            self.toProgress = progress
            
            
            
        }
        
        
    }
    
    func getTime(angle : Double)->Date{
        
        let progress = angle / 30
        
        let hour = Int(progress)
        
        
        let remaindar = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()
        
        
        var minute = remaindar * 5
        
        minute = (minute > 55 ? 55 : minute)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        
        
        if let date = formatter.date(from: "\(hour):\(Int(minute)):00"){
            
            
            return date
        }
        
        return .init()
            
        
        
    }
    
    func getTimerDiffrence() ->(Int,Int){
        
        
        let calendar = Calendar.current
        
       let result =  calendar.dateComponents([.hour,.minute], from: getTime(angle: startAngle),to: getTime(angle: totAngle))
        
        return (result.hour ?? 0 ,result.minute ?? 0)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}
