//
//  UserCheckTicketController.m
//  CheckAirTicket
//
//  Created by Mars on 16/6/6.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "UserCheckTicketController.h"
#import "selectJourney.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "SelectStartCitytableVC.h"
#import "AirPlanTicketPriceTBVC.h"
#import "UserCheckTricketModel.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
@interface UserCheckTicketController () <UITableViewDataSource , UITableViewDelegate , UIWebViewDelegate>

{
    CalendarHomeViewController *chvc;
}

@property (weak, nonatomic) IBOutlet UITableView *UserCheckTicketTabblView;

@property (nonatomic ,strong)UIWebView *checkTicketWebView; ///<选择查询界面webView

@property(nonatomic,copy)NSString *dataBtnVaule;//<日期按钮的值

@property (nonatomic ,strong)NSMutableArray *ticketInfo;//<机票所需数据

@property (nonatomic ,strong)NSMutableDictionary *ticketDict;//<机票的字典

@property(nonatomic,copy)NSString *startTime;//<起始时间

@property(nonatomic,copy)NSString *endTime;//<降落时间

@property(nonatomic,copy)NSString *startPlace;//<起飞地点

@property(nonatomic,copy)NSString *endPlace;//<降落地点

@property(nonatomic,copy)NSString *ticketPrice;//<价格

@property(nonatomic,copy)NSString *moreInfo;//<更多的信息

@property(nonatomic,copy)NSString *companyOne;//<航班

@property(nonatomic,copy)NSString *companyType;//<飞机类型

@property (nonatomic ,strong)UserCheckTricketModel *userModel;

@property (nonatomic ,strong)selectJourney *userCell;

@end

@implementation UserCheckTicketController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //移除数组的数据
    [self.ticketInfo removeAllObjects];
    self.userCell.userInteractionEnabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //UserCheckTicketTabblView 设置代理
    self.UserCheckTicketTabblView.delegate = self;
    self.UserCheckTicketTabblView.dataSource = self;
    //设置checkTicketWebView 代理
    self.checkTicketWebView.delegate = self;
}


#pragma mark 请求webView数据
- (void)loadWebViewData:(NSString *)dataSelect startPlace:(NSString *)startP  endPlace:(NSString *)endP{
    NSString *urlStr = [NSString stringWithFormat:@"http://touch.qunar.com/h5/flight/flightlist?startCity=%@&startCode=PEK&destCity=%@&destCode=SHA&startDate=%@&backDate=&flightType=oneWay",startP,endP,dataSelect];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.checkTicketWebView loadRequest:request];
    NSLog(@"日期:%@ , %@ -----> %@" ,dataSelect,startP,endP);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    for (int i = 0; i < 12; i++) {
        NSString *startTime = [self getTicketDataByJavaScriptClassName:@"from-time time-font" andTicketsArrayIndex:i andwebView:webView];//<起飞时间
        NSString *startPlace = [self getTicketDataByJavaScriptClassName:@"from-place ellipsis" andTicketsArrayIndex:i andwebView:webView];//<起飞机场
        NSString *endTime = [self getTicketDataByJavaScriptClassName:@"to-time time-font" andTicketsArrayIndex:i andwebView:webView];//<降落时间
        NSString *endPlace = [self getTicketDataByJavaScriptClassName:@"to-place ellipsis" andTicketsArrayIndex:i andwebView:webView];//<降落机场
        NSString *ticketPrice = [self getTicketDataByJavaScriptClassName:@"price" andTicketsArrayIndex:i andwebView:webView];//<价格
        NSString *moreInfo = [self getTicketDataByJavaScriptClassName:@"more-info" andTicketsArrayIndex:i andwebView:webView];//<更多的信息
        NSString *companyOne = [self getTicketDataByJavaScriptClassName:@"company1 ellipsis" andTicketsArrayIndex:i andwebView:webView];//<航班
        NSString *companyType = [self getTicketDataByJavaScriptClassName:@"company2 ellipsis" andTicketsArrayIndex:i andwebView:webView];//<飞机类型
        UserCheckTricketModel *model = [UserCheckTricketModel UserCheckTricketModelWithDict:@{
            @"startTime_M" : startTime,   @"endTime_M" : endTime,   @"startPlace_M" : startPlace,
            @"endPlace_M" : endPlace,     @"ticketPrice_M" : ticketPrice,@"moreInfo_M" : moreInfo,
            @"companyOne_M" : companyOne, @"companyType_M" : companyType,
            }];
        [self.ticketInfo addObject:model];
    }
    [SVProgressHUD dismiss];//<页面跳转dissmiss SVP
//    weakCell.userInteractionEnabled = NO;
    AirPlanTicketPriceTBVC *apVC = [[AirPlanTicketPriceTBVC alloc] init];
    apVC.ticketInfo = self.ticketInfo;
    [self.navigationController pushViewController:apVC animated:YES];//<push
}
/*
 HTML 相关标签属性:
 起始时间className:from-time time-font  起始机场:from-place ellipsis
 降落时间className:to-time time-font    降落机场:to-place ellipsis
 价格 : price-info  更多信息:more-info
 航班:company1 ellipsis   飞机类型:company2 ellipsis
 */
//根据className查找相应的value
- (NSString *)getTicketDataByJavaScriptClassName:(NSString *)className  andTicketsArrayIndex:(int)index  andwebView:(UIWebView *)webView{
    NSString *jsSelect = [NSString stringWithFormat:@"document.getElementsByClassName('%@')[%d].innerHTML",className,index];//<执行H5界面元素查找
    NSString *ticketInfo = [webView stringByEvaluatingJavaScriptFromString:jsSelect];
    return ticketInfo;
}

#pragma mark  UserCheckTicketTabblView 数据源  代理方法
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-  (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    selectJourney *cell = [selectJourney regiestCell:tableView];
    self.userCell = cell;
    [self dataCallBack:cell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIScreen mainScreen].bounds.size.height;
}


#pragma mark Celldatablock实现
- (void)dataCallBack:(selectJourney *)cell{
    __weak typeof (self)weakSelf = self;
    __weak typeof (selectJourney *)weakCell = cell;
    cell.dataCallback = ^(){
    if (!chvc) {
        chvc = [[CalendarHomeViewController alloc]init];
        chvc.calendartitle = @"日历";
        [chvc setAirPlaneToDay:365 ToDateforString:nil];//<初始化方法
    }
    chvc.calendarblock = ^(CalendarDayModel *model){
        NSString *dataM = [model toString];
        NSRange range1 = NSMakeRange(5, 2);
        NSString *dataM1 = [dataM substringWithRange:range1];
        NSRange range2 = NSMakeRange(8, 2);
        NSString *dataM2 = [dataM substringWithRange:range2];
        weakCell.selectDate.text = [NSString stringWithFormat:@"%@月%@日",dataM1,dataM2];
        weakCell.data = dataM;//<记录选中的值
};
    [self.navigationController pushViewController:chvc animated:YES];
    };
    
    cell.startPlaceCallBack = ^(){//<始发地选中回调
        SelectStartCitytableVC *svc = [[SelectStartCitytableVC alloc] init ];
        [self.navigationController pushViewController:svc animated:YES];
        svc.cityCallBack = ^(NSString *city){
        weakCell.startP.text = city;
        };
    };
    
    cell.endPlaceCallBack = ^(){//<目的地选中回调
        SelectStartCitytableVC *svc = [[SelectStartCitytableVC alloc] init ];
        [self.navigationController pushViewController:svc animated:YES];
        svc.cityCallBack = ^(NSString *city){
        weakCell.endP.text = city;
        };
    };
 
    cell.searchDataCallBack = ^(NSString *dataSelect , NSString *startP , NSString *endP){
        [SVProgressHUD showProgress:1.0 status:@"正在加载ing....."];
        weakCell.userInteractionEnabled = NO;
        [weakSelf loadWebViewData:dataSelect startPlace:startP endPlace:endP];//<webView请求数据
    };
}
#pragma mark lazyLoading

- (UIWebView *)checkTicketWebView{
    if(_checkTicketWebView == nil){
        _checkTicketWebView = [[UIWebView alloc] init];
    }
    return _checkTicketWebView;
}

- (NSMutableArray *)ticketInfo{
    if(_ticketInfo == nil){
        _ticketInfo = [NSMutableArray array];
    }
    return _ticketInfo;
}

- (NSMutableDictionary *)ticketDict{
    if(_ticketDict == nil){
    _ticketDict = [NSMutableDictionary dictionary];
}
    return _ticketDict;
}
@end
