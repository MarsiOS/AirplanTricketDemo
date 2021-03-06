//
//  selectJourney.m
//  CheckAirTicket
//
//  Created by Mars on 16/6/6.
//  Copyright © 2016年 Mars. All rights reserved.
//


#import "selectJourney.h"
#import "SVProgressHUD.h"
@interface selectJourney ()

@end

@implementation selectJourney


+ (instancetype)regiestCell:(UITableView *)tableView{
    return [[[NSBundle mainBundle] loadNibNamed:@"selectJourney" owner:self options:nil]lastObject];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    //MARK:获得当前日期
    NSDate *date = [NSDate  date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [fmt stringFromDate:date];
    self.data = dateStr;
    NSRange rangeDate1 = NSMakeRange(5, 2);
    NSString *dataM1 = [dateStr substringWithRange:rangeDate1];
    NSRange rangeDate2 = NSMakeRange(8, 2);
    NSString *dataM2 = [dateStr substringWithRange:rangeDate2];
    self.selectDate.text = [NSString stringWithFormat:@"%@月%@日",dataM1,dataM2];
}

//初始地点
- (IBAction)startPlaceBtn:(id)sender {
    self.startPlaceCallBack();
}

//目的地点
- (IBAction)endPlaceBtn:(id)sender {
    self.endPlaceCallBack();
}

//双向按钮
- (IBAction)ovonicPlaceBtn:(id)sender {

    NSString *temp = self.startP.text;
    self.startP.text = self.endP.text;
    self.endP.text = temp;
    
}

//日期选择
- (IBAction)sellectDateBtn:(id)sender {
    self.dataCallback();
}

//搜索btn
- (IBAction)searchBtn:(id)sender {
    if([self.startP.text isEqualToString:self.endP.text]){
        [SVProgressHUD showErrorWithStatus:@"起始地点一致,请重新选择"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
            [SVProgressHUD dismiss];
        });
            self.userInteractionEnabled = NO;
        return;
    }
    self.searchDataCallBack(self.data,self.startP.text,self.endP.text);
}

//segmentBtn
- (IBAction)startAndEndBtnClick:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

@end
