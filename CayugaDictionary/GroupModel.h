//
//  GroupModel.h
//  CayugaDictionary
//
//  Created by cz5670 on 2017-09-27.
//  Copyright © 2017 winemocol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupModel : UITableViewCell
@property (nonatomic, assign)BOOL isOpened;
@property (nonatomic, retain)NSString *groupName;
@property (nonatomic, assign)NSInteger groupCount;
@property (nonatomic, retain)NSArray *groupFriends;
@end
