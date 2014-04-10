//
//  CYPageViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-10.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYPageViewController.h"
#import "UIViewController+MMDrawerController.h"
@interface CYPageViewController ()

@end

@implementation CYPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    currentIndex = 0;
    [super viewDidLoad];
    [self indexChange:1];
    minMoveWidth = self.view.frame.size.width /5.0f;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeTapNavigationBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}
-(CYPageView *) createView:(int)index
{
    NSMutableString *string = [NSMutableString string];
    for(int i=0;i<10000;i++)
    {
        [string appendFormat:@"%d",index,nil];
    }
    CYPageView *vi = [[CYPageView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.bounds.size.height-20) txt:string];
    vi.hidden = YES;
    vi.finishedMove = ^(void){
        [self indexChange:nextPageIndex];
        [self.view setUserInteractionEnabled:YES];
    };
    return vi;
}
-(void) indexChange:(int)newIndex
{
    if(currentIndex == newIndex)
        return;
    if(currentIndex ==0)
    {
        [self setVisitPage:[self createView:newIndex]];
        [self.view addSubview:self.visitPage];
        self.visitPage.hidden = NO;
    }
    if(newIndex>0)
    {
        if (newIndex>currentIndex)
        {
            if(self.prePage)
            {
                [self.prePage removeFromSuperview];
                
            }
            if(newIndex>1)
            {
                [self setPrePage:self.visitPage];
                [self setVisitPage:self.nextPage];
            }
            [self setNextPage:[self createView:newIndex+1]];
            [self.view insertSubview:self.nextPage  atIndex:0];
        }
        else
        {
            if(self.nextPage)
            {
                [self.nextPage removeFromSuperview];
            }
            [self setNextPage:self.visitPage];
            [self setVisitPage:self.prePage];
            if(newIndex > 1)
            {
                [self setPrePage:[self createView:newIndex-1]];
                
                [self.view addSubview:self.prePage];
            }
            else
            {
                [self setPrePage:nil];
            }
        }
        currentIndex = newIndex;
    }
    
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    startX = x;
    fromLeft = x< self.view.frame.size.width /2;
    tap = YES;
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(fromLeft && currentIndex <=1)
        return;
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
//    CGRect rect = _visitPage.frame;
    if (fromLeft) {
        //self.nextPage.hidden = NO;
        if(self.prePage)
        {
            self.prePage.hidden = NO;
            self.nextPage.hidden = YES;
            [_prePage move:x animation:NO];
        }
        
    }
    else
    {
        self.prePage.hidden = YES;
        self.nextPage.hidden = NO;
        [_visitPage move:x animation:NO];
        
    }
    tap = NO;
    
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    
    if (!fromLeft && (tap||startX - x >minMoveWidth))
    {
        [self.view setUserInteractionEnabled:NO];
        self.nextPage.hidden = NO;
        nextPageIndex = currentIndex+1;
        [_visitPage move:-self.view.frame.size.width animation:YES];
    }
    else if(!fromLeft && startX - x <=minMoveWidth)
    {
        [self.view setUserInteractionEnabled:NO];
        [_visitPage move:self.view.frame.size.width animation:YES];
    }
    else if(currentIndex >1)
    {
        [self.view setUserInteractionEnabled:NO];
        _prePage.hidden = NO;
        if (fromLeft && (tap||x-  startX >minMoveWidth))
        {
            nextPageIndex = currentIndex-1;
            [_prePage move:self.view.frame.size.width animation:YES];
        }
        else if(fromLeft &&  x - startX<=minMoveWidth)
        {
            [_prePage move:-self.view.frame.size.width animation:YES];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
