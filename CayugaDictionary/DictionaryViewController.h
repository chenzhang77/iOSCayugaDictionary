//
//  DictionaryViewController.h
//  CayugaDictionary
//
//  Created by cz5670 on 2017-09-27.
//  Copyright © 2017 winemocol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DictionaryViewController : UIViewController
@property(nonatomic,strong)NSString *titleString;
- (void)filterContentForSearchText:(NSString*)searchText;
@end
