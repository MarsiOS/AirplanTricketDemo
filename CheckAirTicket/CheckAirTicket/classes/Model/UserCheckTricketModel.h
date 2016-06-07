//
//  UserCheckTricketModel.h
//  CheckAirTicket
//
//  Created by Mars on 16/6/6.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCheckTricketModel : NSObject

@property(nonatomic,copy)NSString *startTime_M;//<起始时间

@property(nonatomic,copy)NSString *endTime_M;//<降落时间

@property(nonatomic,copy)NSString *startPlace_M;//<起飞地点

@property(nonatomic,copy)NSString *endPlace_M;//<降落地点

@property(nonatomic,copy)NSString *ticketPrice_M;//<价格

@property(nonatomic,copy)NSString *moreInfo_M;//<更多的信息

@property(nonatomic,copy)NSString *companyOne_M;//<航班

@property(nonatomic,copy)NSString *companyType_M;//<飞机类型

+ (instancetype)UserCheckTricketModelWithDict:(NSDictionary *)dict;

@end
