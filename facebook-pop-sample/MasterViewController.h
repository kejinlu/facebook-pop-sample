//
//  MasterViewController.h
//  facebook-pop-sample
//
//  Created by Luke on 5/20/14.
//  Copyright (c) 2014 geeklu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end
