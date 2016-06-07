//
//  TicketPriceCell.m
//  CheckAirTicket
//
//  Created by Mars on 16/6/7.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "TicketPriceCell.h"
#import "UserCheckTricketModel.h"
@interface  TicketPriceCell()

@property (weak, nonatomic) IBOutlet UILabel *startTime;//<起始时间

@property (weak, nonatomic) IBOutlet UILabel *startPlace;//<起始地点

@property (weak, nonatomic) IBOutlet UILabel *endTime;//<结束时间

@property (weak, nonatomic) IBOutlet UILabel *endPlace;//<降落地点

@property (weak, nonatomic) IBOutlet UILabel *compnyOne;//<航班号

@property (weak, nonatomic) IBOutlet UILabel *airType;//<飞机类型

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//<价格

@property (weak, nonatomic) IBOutlet UILabel *moreLabel;//<信息

@end

@implementation TicketPriceCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if( self = [super initWithCoder:aDecoder]){

        
    }

    return self;
}

+ (instancetype)registTicketCell:(UITableView *)tableView{

    return [[[NSBundle mainBundle]loadNibNamed:@"TicketPriceCell" owner:self options:nil]lastObject];

}

- (void)setAttr:(UserCheckTricketModel *)attr{
    _attr = attr;
    self.startTime.text = attr.startTime_M;
    self.startPlace.text = attr.startPlace_M;
    self.endPlace.text = attr.endPlace_M;
    self.endTime.text = attr.endTime_M;
    self.compnyOne.text = attr.companyOne_M;
    self.priceLabel.text = attr.ticketPrice_M;
    self.moreLabel.text = attr.moreInfo_M;
    self.airType.text = attr.companyType_M;

}

@end
