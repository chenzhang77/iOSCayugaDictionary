//
//  MenuViewController.m
//  CayugaDictionary
//
//  Created by cz5670 on 2017-09-27.
//  Copyright © 2017 winemocol. All rights reserved.
//
#import "MenuViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "DictionaryViewController.h"
#import "SyncViewController.h"



@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-100, kScreenHeight) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableview];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Cayuga To English";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"English To Cayuga";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Sync";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"About";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 0) {
        DictionaryViewController *pushVC = [[DictionaryViewController alloc] init];
        pushVC.titleString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        
        //拿到我们的LitterLCenterViewController，让它去push
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:pushVC animated:NO];
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    } else if (indexPath.row == 2) {
        //SyncViewController *pushVC = [[SyncViewController alloc] init];
        //pushVC.titleString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
        SyncViewController *pushVC = [[SyncViewController alloc] initWithNibName:@"SyncViewController" bundle:nil];
        //拿到我们的LitterLCenterViewController，让它去push
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:pushVC animated:NO];
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(CGRectGetWidth(view.frame)/2-25, 40, 48, 72);
    imageButton.layer.cornerRadius = 25;
    [imageButton setBackgroundImage:[UIImage imageNamed:@"icon_tabbar_mine_selected"] forState:UIControlStateNormal];
    [view addSubview:imageButton];
    [imageButton addTarget:self action:@selector(imgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageButton.frame)+5, tableView.bounds.size.width, 20)];
    nameLabel.text = @"Cayuga Dictionary";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    return view;
}


- (void)imgButtonAction {
    
    DictionaryViewController *pushVC = [[DictionaryViewController alloc] init];
    pushVC.titleString = @"个人资料";
    
    //拿到我们的LitterLCenterViewController，让它去push
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:pushVC animated:NO];
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
