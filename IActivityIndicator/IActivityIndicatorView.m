//
//  UIActivityIndicatorViewEx.m
//  Foundation
//
//  Created by Jiangcp on 13-4-15.
//
//
#import <UIKit/UIKit.h>

#import "IActivityIndicatorView.h"
#undef	SINGLETON_DECLAR
#define SINGLETON_DECLAR( __class ) \
+ (__class *)shareInstance;

#undef	SINGLETON_DEFINE
#define SINGLETON_DEFINE( __class ) \
+ (__class *)shareInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#define AINDICTORVIEW_HEIGHT 70 //加载背景框长宽
#define ACVBG_COLOR [UIColor blackColor]

//#define g_activity [IActivityIndicatorView shareInstance]
#define g_activity [IActivityIndicatorViewEx shareInstance]
@interface IActivityIndicatorView : UIActivityIndicatorView
@property(nonatomic,assign) int      startCount;
@end

@interface IActivityIndicatorViewEx : UIView
{
    UIActivityIndicatorView *m_indicatorView;
}
@property(nonatomic,assign) int      startCount;
@end

@implementation IActivityIndicatorViewEx
SINGLETON_DEFINE(IActivityIndicatorViewEx);

-(id)init
{
    self = [[IActivityIndicatorViewEx alloc] initWithFrame:CGRectMake(0, 0, AINDICTORVIEW_HEIGHT, AINDICTORVIEW_HEIGHT)];
    if (self) {
        [self setBackgroundColor:ACVBG_COLOR];
        [self.layer setCornerRadius:3];
        
        m_indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:m_indicatorView];
        m_indicatorView.center = self.center;
        [m_indicatorView startAnimating];
        
        [[self window] addSubview:self];
        self.center = [self window].center;
    }
    return self;
}

-(void)setStartCount:(int)count
{
    _startCount = count > 0 ? count : 0;
}

-(UIWindow*)window
{
    return [[UIApplication sharedApplication].delegate window];
}

-(void)show
{
    self.startCount += 1;
    if ( self.startCount >0 ) {
        [m_indicatorView startAnimating];
        self.hidden = NO;
        [[self window] bringSubviewToFront:self];
    }
}

-(void)hidden
{
    self.startCount -= 1;
    if ( self.startCount == 0)
    {
        self.hidden = YES;
        [m_indicatorView stopAnimating];
    }
}

- (void) dealloc
{
    
}
@end

@implementation IActivityIndicatorView
@synthesize startCount;

SINGLETON_DEFINE(IActivityIndicatorView);

-(id)init
{
    self = [super initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.contentMode = UIViewContentModeCenter;
        self.hidesWhenStopped = YES;
        self.userInteractionEnabled = NO;
        
        self.frame = [UIScreen mainScreen].bounds;
        [[self window] addSubview:self];
    }
    return self;
}

-(UIWindow*)window
{
    return [[UIApplication sharedApplication].delegate window];
}

-(void)setStartCount:(int)count
{
    startCount = count > 0 ? count : 0;
}

-(void)show
{
    self.startCount += 1;
    if ( startCount >0 ) {
        [self startAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    [[self window] bringSubviewToFront:self];
}

-(void)hidden
{
    self.startCount -= 1;
    if ( startCount == 0)
    {
        [self stopAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}
@end

#define async_dispatch 1
#define sync_dispatch  0
#define perform        0
void net_activity_indicator_start()
{
#if async_dispatch
    dispatch_async(dispatch_get_main_queue(), ^{
        [g_activity show];
    });
    
#elif sync_dispatch
    if ([[NSThread currentThread] isEqual:[NSThread mainThread]]) {
        [g_activity show];
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [g_activity show];
        });
    }
#elif perform
    [g_activity performSelectorOnMainThread:@selector(show)
                                 withObject:nil
                              waitUntilDone:NO];
    
#endif
}
void net_activity_indicator_stop()
{
#if async_dispatch
    dispatch_async(dispatch_get_main_queue(), ^{
        [g_activity hidden];
    });
#elif sync_dispatch
    if ([[NSThread currentThread] isEqual:[NSThread mainThread]]) {
        [g_activity hidden];
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [g_activity hidden];
        });
    }
#elif perform
    [g_activity performSelectorOnMainThread:@selector(hidden)
                                 withObject:nil
                              waitUntilDone:NO];
#endif
}
