//
//  SyncViewController.m
//  CayugaDictionary
//
//  Created by cz5670 on 2017-10-02.
//  Copyright © 2017 winemocol. All rights reserved.
//



#import "SyncViewController.h"
#import "SRDownloadManager.h"
#import "ZZCircleProgress.h"
#import "ZZCACircleProgress.h"
#import "Reachability.h"
#import <FMDB/FMDatabase.h>
#import <FMDB/FMDatabaseQueue.h>


NSString * const downloadURLString1 = @"ftp://cjdyck:thog3pi7@www.cayugadictionary.ca:21/cayugaOnlineFiles/cayuga-english.txt";
NSString * const downloadURLString2 = @"ftp://cjdyck:thog3pi7@www.cayugadictionary.ca:21/cayugaOnlineFiles/word-initial.txt";
NSString * const downloadURLString3 = @"ftp://cjdyck:thog3pi7@www.cayugadictionary.ca:21/cayugaOnlineFiles/word-medial-1.txt";
NSString * const downloadURLString4 = @"ftp://cjdyck:thog3pi7@www.cayugadictionary.ca:21/cayugaOnlineFiles/word-medial-2.txt";
NSString * const downloadURLString5 = @"ftp://cjdyck:thog3pi7@www.cayugadictionary.ca:21/cayugaOnlineFiles/suffix_list.txt";
NSString * const downloadURLString6 = @"ftp://cjdyck:thog3pi7@www.cayugadictionary.ca:21/cayugaOnlineFiles/words_without_affixes.txt";

#define kDownloadURL1 [NSURL URLWithString:downloadURLString1]
#define kDownloadURL2 [NSURL URLWithString:downloadURLString2]
#define kDownloadURL3 [NSURL URLWithString:downloadURLString3]
#define kDownloadURL4 [NSURL URLWithString:downloadURLString4]
#define kDownloadURL5 [NSURL URLWithString:downloadURLString5]
#define kDownloadURL6 [NSURL URLWithString:downloadURLString6]
#define ZZRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//#define SRDownloadDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] \
stringByAppendingPathComponent:NSStringFromClass([self class])]

@interface SyncViewController ()
@property(nonatomic,strong)NSArray *showArray;
@end

@implementation SyncViewController
{
    ZZCACircleProgress *circle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sync Files";
    self.view.backgroundColor = [UIColor whiteColor];
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *bundlePath = [bundle bundlePath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                 NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //[self test];
    [SRDownloadManager sharedManager].saveFilesDirectory = documentsDirectory;//[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"CustomDownloadDirectory"];
    if([self isNetworkAvailable]){
        [self deleteAllFiles];
        [self sycFileFromServer];
        [self initCircles];
        //self.navigationItem.hidesBackButton = YES;
        //self.navigationItem.backBarButtonItem.title = @"Back";
        //self.navigationController.navigationBar.userInteractionEnabled = NO;
        //self.navigationController.navigationBar.ba
        self.view.window.userInteractionEnabled = NO;
    } else {
        self.navigationController.navigationBar.userInteractionEnabled = YES;
        [self initZeroCircles];
    }
}

-(BOOL)isNetworkAvailable {
    Reachability *hostReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    return !(netStatus == NotReachable);
}

- (void)sycFileFromServer {
    

    __block int count = 0;
    
//    [[SRDownloadManager sharedManager] downloadURL:kDownloadURL2 destPath:nil state:^(SRDownloadState state) {
//    } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
//    } completion:^(BOOL success, NSString *filePath, NSError *error) {
//        if (success) {
//            count ++;
//            if(count == 6) [self processFiles];
//            NSLog(@"FilePath: %@", filePath);
//            NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//            NSString* path_create = [[NSBundle mainBundle] pathForResource:@"word-initial"
//                                                             ofType:@"txt"];
//            
//            NSLog(@"[NSBundle mainBundle]: %@", [NSBundle mainBundle]);
//            NSLog(@"path_create: %@", path_create);
//            
//            NSString* content_create = [NSString stringWithContentsOfFile:path_create encoding:NSUTF8StringEncoding error:nil];
//            NSLog(@"content_create: %@", content_create);
//            
//            NSString* content_create_initial = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//            NSLog(@"content_create_initial: %@", content_create_initial);
//            
//            
//            NSLog(@"content_create: %@", content_create);
//            NSLog(@"content: %@", content);
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];
//
    [[SRDownloadManager sharedManager] downloadURL:kDownloadURL1 destPath:nil state:^(SRDownloadState state) {
        //[button setTitle:[self titleWithDownloadState:state] forState:UIControlStateNormal];
    } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        //        currentSizeLabel.text = [NSString stringWithFormat:@"%zdMB", receivedSize  / 1024];
        //        totalSizeLabel.text = [NSString stringWithFormat:@"%zdMB", expectedSize / 1024 / 1024];
        //        progressLabel.text = [NSString stringWithFormat:@"%.f%%", progress * 100];
        //        progressView.progress = progress;
        
    } completion:^(BOOL success, NSString *filePath, NSError *error) {
        if (success) {
            count ++;
            if(count == 6) [self processFiles];
            NSLog(@"FilePath: %@", filePath);
            [self showArray:filePath];
        } else {
            NSLog(@"Error: %@", error);
        }
    }];
//
//    [[SRDownloadManager sharedManager] downloadURL:kDownloadURL3 destPath:nil state:^(SRDownloadState state) {
//    } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
//    } completion:^(BOOL success, NSString *filePath, NSError *error) {
//        if (success) {
//            count ++;
//            if(count == 6) [self processFiles];
//            NSLog(@"FilePath: %@", filePath);
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];
//    
//    [[SRDownloadManager sharedManager] downloadURL:kDownloadURL4 destPath:nil state:^(SRDownloadState state) {
//    } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
//    } completion:^(BOOL success, NSString *filePath, NSError *error) {
//        if (success) {
//            count ++;
//            if(count == 6) [self processFiles];
//            NSLog(@"FilePath: %@", filePath);
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];
//    
//    [[SRDownloadManager sharedManager] downloadURL:kDownloadURL5 destPath:nil state:^(SRDownloadState state) {
//    } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
//    } completion:^(BOOL success, NSString *filePath, NSError *error) {
//        if (success) {
//            count ++;
//            if(count == 6) [self processFiles];
//            NSLog(@"FilePath: %@", filePath);
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];
//    
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    [[SRDownloadManager sharedManager] downloadURL:kDownloadURL6 destPath:documentsDirectory state:^(SRDownloadState state) {
//    } progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
//    } completion:^(BOOL success, NSString *filePath, NSError *error) {
//        if (success) {
//            count ++;
//            if(count == 6) [self processFiles];
//            NSLog(@"FilePath: %@", filePath);
//           // [self showArray:filePath];
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];
    
}

- (void)processFiles {
    NSLog(@"processFiles ---------- ");
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (void) test {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cayuga-english" ofType:@"txt"];
    NSLog(@"path %@",path);
    NSLog(@"[NSBundle mainBundle] %@",[NSBundle mainBundle]);
    NSArray *writablePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [writablePaths lastObject];
    NSString *fileInDocuments = [documentsPath stringByAppendingPathComponent:@"word-initial.txt"];
    NSLog(@"fileInDocuments %@",fileInDocuments);
    NSString *countryString = [NSString stringWithContentsOfFile:fileInDocuments encoding:NSUTF16StringEncoding error:nil];
    //        NSData *contentOfLocalFile = [NSData dataWithContentsOfURL:filepath];
    NSLog(@"countryString %@",countryString);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"word-initial.txt"];
    NSLog(@"filePath %@",filePath);
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF16StringEncoding error:NULL];
    NSLog(@"content %@",content);
}

- (NSArray *)showArray:(NSString*) filepath{
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *fileNames = [fileManager contentsOfDirectoryAtPath:SRDownloadDirectory error:nil];
//    NSLog(@"SRDownloadDirectory  ===%@",SRDownloadDirectory);
//    NSLog(@"fileNames count %lu", (unsigned long)[fileNames count]);
//    for (NSString *fileName in fileNames) {
//        NSString *filePath_inner = [SRDownloadDirectory stringByAppendingPathComponent:fileName];
//        NSLog(@"filePath_inner  ===%@",filePath_inner);
//        //[fileManager removeItemAtPath:filePath error:nil];
//    }
    
    
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *bundlePath = [bundle bundlePath];
//    NSLog(@"Bundle: %@", bundle);
//    
//    
//    NSArray *writablePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [writablePaths lastObject];
//    NSString *fileInDocuments = [documentsPath stringByAppendingPathComponent:@"file.plist"];
//    NSLog(@"fileInDocuments File:%@", fileInDocuments);
//    
//    NSString *tmpDirectory = NSTemporaryDirectory();
//    NSString *tmpFile = [tmpDirectory stringByAppendingPathComponent:@"temp.txt"];
//    
//    NSLog(@"Temp File:%@", tmpFile);
//    
//    
//    
//    NSLog(@"File: %@", fileInDocuments);
//    
//    return _showArray;

//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSLog(@"SRDownloadDirectory: %@", SRDownloadDirectory);
//    NSString *file = [SRDownloadDirectory stringByAppendingPathComponent:filepath];
//    NSLog(@"SRDownloadDirectory: file %@",file);
//    NSArray *fileNames = [fileManager contentsOfDirectoryAtPath:SRDownloadDirectory error:nil];
//    for (NSString *fileName in fileNames) {
//        NSString *filePath = [SRDownloadDirectory stringByAppendingPathComponent:fileName];
//        [fileManager removeItemAtPath:filePath error:nil];
//    }
    
    
    if (_showArray == nil) {
//        NSString *path = filepath;//[[NSBundle mainBundle] pathForResource:filepath ofType:nil];
//        NSLog(@"path %@",path);
//        NSLog(@"[NSBundle mainBundle] %@",[NSBundle mainBundle]);
        
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                             NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *testpath = [documentsDirectory stringByAppendingPathComponent:filepath];
//        NSLog(@"documentsDirectory %@",documentsDirectory);
//        NSLog(@"path %@",testpath);
        
        NSString *countryString = [NSString stringWithContentsOfFile:filepath encoding:NSUTF16StringEncoding error:nil];
//        NSData *contentOfLocalFile = [NSData dataWithContentsOfURL:filepath];
        NSLog(@"countryString %@",countryString);
//        _showArray = [countryString componentsSeparatedByString:@"\n"];
        
    }
    return _showArray;
}


-(void) deleteAllFiles {
    [[SRDownloadManager sharedManager] deleteAllFiles];
}

- (void)initCircles {
    
    CGFloat xCrack = ([UIScreen mainScreen].bounds.size.width-150*2)/8.0;
    CGFloat yCrack = ([UIScreen mainScreen].bounds.size.height-150*2)/8.0;
    CGFloat itemWidth = 150;
    //circle = [[ZZCACircleProgress alloc] initWithFrame:CGRectMake(4*xCrack+itemWidth/2.0, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:-255 strokeWidth:10];
    circle = [[ZZCACircleProgress alloc] initWithFrame:CGRectMake(4*xCrack+itemWidth/2.0, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(204, 153, 255) startAngle:-255 strokeWidth:10];
    circle.reduceAngle = 30;
    circle.increaseFromLast = YES;
    circle.pointImage.image = [UIImage imageNamed:@"test_point"];
    circle.duration = 5;
    circle.prepareToShow = YES;
    circle.progress = 1;
    [self.view addSubview:circle];
    
}
- (void)initZeroCircles {
    
    CGFloat xCrack = ([UIScreen mainScreen].bounds.size.width-150*2)/8.0;
    CGFloat yCrack = ([UIScreen mainScreen].bounds.size.height-150*2)/8.0;
    CGFloat itemWidth = 150;
    //circle = [[ZZCACircleProgress alloc] initWithFrame:CGRectMake(4*xCrack+itemWidth/2.0, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(arc4random()%255, arc4random()%255, arc4random()%255) startAngle:-255 strokeWidth:10];
    circle = [[ZZCACircleProgress alloc] initWithFrame:CGRectMake(4*xCrack+itemWidth/2.0, yCrack*2+itemWidth, itemWidth, itemWidth) pathBackColor:nil pathFillColor:ZZRGB(204, 153, 255) startAngle:-255 strokeWidth:10];
    circle.reduceAngle = 30;
    circle.increaseFromLast = YES;
    circle.pointImage.image = [UIImage imageNamed:@"test_point"];
    circle.duration = 5;
    circle.prepareToShow = YES;
    circle.progress = 0;
    [self.view addSubview:circle];
    
}

@end

