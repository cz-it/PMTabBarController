/*******************************************************************************\
** PMTabBarController:PMTabBarController.m
** Created by CZ(cz.devnet@gmail.com) on 21/11/2016
**
**  Copyright © 2016 projm. All rights reserved.
\*******************************************************************************/


#import "PMTabBarController.h"

@interface PMTabBarController ()

@end

@implementation PMTabBarController {
    NSMutableArray *_masks;
    NSArray *_viewControllers;
}

- (instancetype) init {
    if (self = [super init]) {
        _masks = [NSMutableArray new];
        [self addObserver:self forKeyPath:@"viewControllers" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [self updateTabBarItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateTabBarItems {

    NSMutableArray *newVCs = [[NSMutableArray alloc] initWithArray:_viewControllers];
    NSUInteger num = _masks.count;
    for (int i=0; i<_masks.count; i++) {
        NSDictionary *dict = [_masks objectAtIndex:i];
        UIView *maskView = [dict objectForKey:@"maskView"];
        UIViewController *vc = [dict objectForKey:@"viewController"];
        UIView *v = [dict objectForKey:@"view"];
        NSNumber *idx = [dict objectForKey:@"index"];
        if (nil != maskView && nil != v && nil != vc && nil != idx) {
            [self layoutMaskView: maskView atIndex: idx.unsignedIntegerValue];
            [self addItemView:v];
            [newVCs insertObject:vc atIndex:idx.unsignedIntegerValue];
        }
    }
    NSArray *tmpVCs = [[NSArray alloc] initWithArray:_viewControllers];
    self.viewControllers = newVCs;
    _viewControllers = tmpVCs;
}

- (void) layoutMaskView:(UIView *) view atIndex:(NSUInteger) index {
    int unitNum = _masks.count + _viewControllers.count;
    float unitW = self.tabBar.frame.size.width/(unitNum>0?unitNum:1);
    float x = (unitW) * index ;
    float y = self.tabBar.frame.origin.y;
    float width = unitW;
    float height = self.tabBar.frame.size.height;

    [view setFrame:CGRectMake(x, y, width, height)];
    //view.userInteractionEnabled = NO; //no need
    //[view setBackgroundColor:[UIColor greenColor]];
}

- (void) addItemView : (UIView *) view {
    int unitNum = _masks.count + self.viewControllers.count;
    float unitW = (self.tabBar.frame.size.width)/(unitNum>0?unitNum:1);
    float x =16+ (unitW - view.frame.size.width) /2;
    x = x>0 ? x:0;
    float y = (self.tabBar.frame.size.height - view.frame.size.height)/2;
    y = y>0 ? y : y;
    float width = view.frame.size.width;
    float height = view.frame.size.height;
    [view setFrame:CGRectMake(x, y, width, height)];    
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"viewControllers"]) {
        NSArray *newVCs = [change objectForKey:NSKeyValueChangeNewKey];
        if (nil == newVCs) {
            return ;
        }
        _viewControllers = newVCs;
    }
    
}

- (BOOL) insertView: (UIView *) view atIndex: (NSUInteger) index {
    // insert's view dosn't in count
    NSUInteger num =  self.viewControllers.count;
    if (num<index) {
        return NO;
    }

    UIView *maskView = [UIView new];
    UIViewController *maskVC = [UIViewController new];
    [maskView addSubview:view];
    [self.view addSubview:maskView]; // when to remove this from rootView
    [_masks addObject:@{@"view": view, @"viewController":maskVC, @"maskView": maskView, @"index":[NSNumber numberWithUnsignedInteger: index]}];
    
    [self updateTabBarItems];

    return YES;
}

@end
