//
//  AirPlanTicketPriceTBVC.m
//  CheckAirTicket
//
//  Created by Mars on 16/6/7.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "AirPlanTicketPriceTBVC.h"
#import "TicketPriceCell.h"
@interface AirPlanTicketPriceTBVC ()

@end

@implementation AirPlanTicketPriceTBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 200;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(test:)];
}

- (void)test:(UINavigationItem *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ticketInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TicketPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"T_cell"];
    if (cell == nil) {
        cell = [TicketPriceCell registTicketCell:tableView];
    }
    cell.attr = self.ticketInfo[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


@end
