//
//  selectJourney.h
//  CheckAirTicket
//
//  Created by Mars on 16/6/6.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myblock)();

typedef void(^searchCallBack)(NSString *dataSelect , NSString *startP , NSString *endP);

@interface selectJourney : UITableViewCell

+ (instancetype)regiestCell:(UITableView *)tableView;//<注册cell

@property(nonatomic,copy)myblock dataCallback;//<日期按钮选择回调

@property(nonatomic,copy)myblock startPlaceCallBack;//<开始地点点击回调

@property(nonatomic,copy)myblock endPlaceCallBack;//<目的地点击回调

@property(nonatomic,copy)searchCallBack searchDataCallBack;//搜索按钮回调

@property (weak, nonatomic) IBOutlet UIButton *dataSelectBtn;//<选择日期btn

@property (weak, nonatomic) IBOutlet UILabel *startP;

@property (weak, nonatomic) IBOutlet UILabel *endP;

@property(nonatomic,copy)NSString *currentDate; //<当前时间

@property(nonatomic,copy)NSString *data;//<带年月日时间

@property (weak, nonatomic) IBOutlet UIButton *startPBtn;//<出发地点btn

@property (weak, nonatomic) IBOutlet UIButton *endPBtn;//<目的地Btn

@end
