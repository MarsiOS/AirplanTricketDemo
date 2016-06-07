//
//  TicketPriceCell.h
//  CheckAirTicket
//
//  Created by Mars on 16/6/7.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserCheckTricketModel;

@interface TicketPriceCell : UITableViewCell

+(instancetype)registTicketCell:(UITableView *)tableView;//<注册自定义cell
@property (nonatomic ,strong)UserCheckTricketModel *attr;//<模型

@end
