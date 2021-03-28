//
//  ContentView.swift
//  Shared
//
//  Created by Vivek Singh on 27/03/21.
//

import SwiftUI



var themeColor =  Color(.systemYellow)

struct ContentView: View {
    @State private var searchEntry = ""
    let manager = ContentManager()
    var body: some View {
        GeometryReader  { metrics in
            ScrollView(.vertical){
                ZStack(alignment:.leading){
                    Circle()
                        .frame(width: 100, height: 100, alignment: .top)
                        .foregroundColor(themeColor).opacity(0.4)
                        .position(x:20, y: 0)
                    
                    VStack(alignment: .leading){
                        Text("ENJOY READING")
                            .italic()
                            .fontWeight(.heavy)
                            .font(.title)
                            .padding(.leading,20)
                            .padding(.top,20)
                        
                        
                        TextField("Search for books", text:$searchEntry)
                            .padding(10)
                            .frame(width: metrics.size.width - 30 , height: 40)
                            .foregroundColor(.white)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                            .padding()
                        
                        HeaderView(width: metrics.size.width - 50, books: manager.getfeaturdBooks())
                        BodyView(books: manager.getRecentlyReadBooks(), width: metrics.size.width - 30)
                            .padding(.top,20)
                        
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct HeaderView : View {
    var width : CGFloat = 200
    var books : [Book]
    var body : some View {
        VStack(alignment: .leading){
            Text("Featured Books").font(.headline).padding(.leading , 15)
            ScrollView(.horizontal){
                HStack(spacing:10){
                    ForEach(books){book in
                        Card(width: width, image: book.coverImage,name:book.title)
                    }
                }.frame(height: 200).padding()
            }
            
            HStack(alignment: .center){
                Button(""){
                    //action
                }.buttonStyle(SpringWithImage(bgColor: .white, imageName: "text.book.closed", name: "Library ")).frame(maxWidth:.infinity)
                Button(""){
                    //action
                }.buttonStyle(SpringWithImage(bgColor: .white, imageName: "bookmark.circle.fill", name: "My Books")).frame(maxWidth:.infinity)
                Button(""){
                    //action
                }.buttonStyle(SpringWithImage(bgColor: .white, imageName: "text.book.closed", name: "Book List")).frame(maxWidth:.infinity)
                Button(""){
                    //action
                }.buttonStyle(SpringWithImage(bgColor: .white, imageName: "text.book.closed", name: "Book List")).frame(maxWidth:.infinity)
            }.padding(.leading, 15)
            
            
        }
    }
}

struct BodyView : View {
    var books : [Book]
    var width : CGFloat = 350
    var body : some View{
        VStack(alignment:.leading){
            Text("Recently read books").font(.headline).padding(.leading , 15)
            ForEach(books){  book in
                ListCard(title: book.title, coverImage: book.coverImage, description: book.oneLiner, width: width)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct Card : View{
    
    var width : CGFloat = 350
    var height : CGFloat = 150
    var image: String
    var name : String
    var body: some View{
        
        VStack{
            ZStack{
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width , height:height)
                
                
                themeColor.opacity(0.7).cornerRadius(15)
                Text(name).bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.black).frame(width: width, height: height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }.background(Color.white.cornerRadius(15).shadow(color: .gray, radius: 2, x: 1.0, y: 1)
        )
    }
    
}



struct ListCard : View {
    var title : String
    var coverImage : String
    var description : String = ""
    var width : CGFloat = 350
    var body : some View {
        ZStack{
            //            Rectangle().background(Color.white).frame(width:width).foregroundColor(.white)
            HStack(alignment:.top){
                Image(coverImage).resizable().frame(width:60, height: 80).aspectRatio(contentMode: .fill).cornerRadius(7.0)
                VStack(alignment:.leading){
                    Text(title).font(.system(size: 14)).foregroundColor(Color(.black)).lineLimit(1)
                    Text(description).font(.system(size: 10)).foregroundColor(.gray).lineLimit(2)
                    HStack{
                        Spacer()
                        Button(action:{
                            
                        }){
                            ZStack{
                                Rectangle().foregroundColor(themeColor).frame(width: 70, height: 25).cornerRadius(12.5, corners: [.bottomLeft, .bottomRight, .topRight])
                                Text("Read Me").font(.system(size: 12)).fontWeight(.regular).foregroundColor(.white)
                            }
                        }
                    }
                }.padding(5)
                Spacer()
            }.frame(width: width - 15)
            .padding(.leading, 7)
        }.frame(width:width - 5 , height: 100)
        .background(Color.white.cornerRadius(15).shadow(color: .gray, radius: 2, x: 1.0, y: 1))
        .padding(.leading, 15)
        
    }
}


struct SpringWithImage: ButtonStyle {
    var bgColor: Color
    var imageName : String
    var name : String
    
    func makeBody(configuration: Self.Configuration) -> some View {
        VStack{
            Image(systemName: imageName).font(.system(size: 30)).foregroundColor(themeColor)
            Text(name).font(.system(size: 10)).foregroundColor(Color(.systemOrange)).padding(.top, 1)
        }.frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .scaleEffect(configuration.isPressed ? 0.60 : 1)
        .animation(.spring())
    }
}


struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

