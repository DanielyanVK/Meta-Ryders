//
//  NetworkingService.swift
//  Meta Ryders
//
//  Created by Vladislav on 04.04.2022.
//

import Foundation
import Combine
// Setting up dummy network service to move out items and other data for homeViewController
class NetworkingService {
    public func fetchNews() -> Future<[News], Error> {
        return Future { promise in
            let news: [News] = [
                News(title: "Coinbase is Partnering with MasterCard to Allow Card Pay", imageName: "news1", article: "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure? On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee.", timePosted: "1 hour ago", sourceName: "bloomberg.com"),
                News(title: "Cardano (ADA) Sureges 31% After New Metaverse Launch", imageName: "news2", article: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc feugiat lobortis leo nec cursus. Etiam pretium non massa in volutpat. Pellentesque nec rutrum ante. Etiam porttitor, elit quis malesuada faucibus, neque nisi tristique nisl, non sodales tortor odio in dolor. Praesent mi risus, tincidunt sed elit ut, pretium iaculis nisi. Fusce nunc eros, accumsan at placerat fringilla, auctor non felis. Sed pharetra ultricies libero at commodo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed ultricies augue eget mi finibus vehiculdAliquam pharetra volutpat est eget pellentesque. Praesent ut ligula varius nisi pretium pretium vel in est. In blandit ante at nisi porta condimentum. Aliquam erat volutpat. Aenean vitae tincidunt urna. Aenean et venenatis lectus. Quisque mollis, odio id commodo mollis, est eros rhoncus tellus, tempus hendrerit leo lorem ac dui. Nunc odio eros, consectetur at iaculis id, maximus finibus orci. Morbi placerat nec sem vitae pulvinar. Proin vel volutpat tellus. Quisque condimentum dignissim augue, ut efficitur nunc dictum.", timePosted: "20 min ago", sourceName: "newyorktimes.com"),
                News(title: "Apple is Prepared to Dominate the Metaverse in 2024", imageName: "news3", article: "It is a period of civil war. Rebel spaceships, striking from a hidden base, have won their first victory against the evil Galactic Empire. During the battle, Rebel spies managed to steal secret plans to the Empire’s ultimate weapon, the DEATH STAR, an armoured space station with enough power to destroy an entire planet.", timePosted: "35 min ago", sourceName: "dailybugle.com")
            ]
            promise(.success(news))
        }
    }
    
    public func fetchItems() -> Future<[Item], Error> {
        return Future { promise in
            let items: [Item] = [
                Item(name: "Bella Doll", imageName: "BellaDoll", description: "These ancient beings have been around since the dawn of time...", price: 98.37, growth: 10, modelName: "converse_obj.obj"),
                Item(name: "Abstract Pink", imageName: "AbstractPainting", description: "A CNS or UNS blockhain domain.", price: 0.906, growth: 6.2, modelName: "Squid_Games_Leader_mask.obj")
            ]
            promise(.success(items))
        }
    }
    // Later on we will use filter function to filter out items from method above instead of doing this
    public func fetchFallableItems() -> Future<[Item], Error> {
        return Future { promise in
            let items: [Item] = [
                Item(name: "Monkey", imageName: "AbstractPainting2", description: "The only thing is out for Harambe - is that T-pose", price: 1.314, growth: -5, modelName: "converse_obj.obj"),
                Item(name: "Wave", imageName: "BellaDoll2", description: "Cool abstract painting", price: 2.212, growth: 35, modelName: "Squid_Games_Leader_mask.obj")
            ]
            promise(.success(items))
        }
    }
   
}
