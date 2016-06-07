//
//  UserCheckTricketModel.m
//  CheckAirTicket
//
//  Created by Mars on 16/6/6.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "UserCheckTricketModel.h"

@implementation UserCheckTricketModel

+ (instancetype)UserCheckTricketModelWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    if(obj){
        [obj setValuesForKeysWithDictionary:dict];
    }
    return obj;
}

@end
