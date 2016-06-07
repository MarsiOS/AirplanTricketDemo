//
//  SelectStartCitytableVC.h
//  CheckAirTicket
//
//  Created by Mars on 16/6/7.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectCityCallBack)(NSString *city);

@interface SelectStartCitytableVC : UITableViewController

//选中城市回调
@property(nonatomic,copy)selectCityCallBack cityCallBack;
@end
