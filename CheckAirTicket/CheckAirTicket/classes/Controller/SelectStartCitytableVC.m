//
//  SelectStartCitytableVC.m
//  CheckAirTicket
//
//  Created by Mars on 16/6/7.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "SelectStartCitytableVC.h"

@interface SelectStartCitytableVC ()

@property (nonatomic ,strong)NSArray *arrM;

@end

@implementation SelectStartCitytableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.textLabel.text = self.arrM[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.cityCallBack(self.arrM[indexPath.row]);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSArray *)arrM{

    if (_arrM == nil) {
        _arrM = [[NSArray alloc] initWithObjects:@"广州",@"深圳",@"北京",@"上海",@"成都",@"长沙",@"厦门",@"三亚",@"南京",@"杭州", nil];
    }
    
    return _arrM;
}
@end
