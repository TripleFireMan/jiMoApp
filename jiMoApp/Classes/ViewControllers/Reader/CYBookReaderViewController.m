//
//  CYBookReaderViewController.m
//  jiMoApp
//
//  Created by 成焱 on 14-4-8.
//  Copyright (c) 2014年 chengYan. All rights reserved.
//

#import "CYBookReaderViewController.h"

@interface CYBookReaderViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)back:(id)sender;
@end

@implementation CYBookReaderViewController

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
    self.title = self.bookName;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
//                                              initWithTitle:@"返回"
//                                              style:UIBarButtonItemStylePlain
//                                              target:self
//                                              action:@selector(GoBack:)];
    NSString *txt = [NSString stringWithContentsOfFile:self.txtAbsoluteUrl encoding:NSUTF8StringEncoding error:nil];
    if (txt==nil) {
        txt = [NSString stringWithContentsOfFile:self.txtAbsoluteUrl encoding:0x80000632 error:nil];
    }
    if (txt==nil) {
        txt = [NSString stringWithContentsOfFile:self.txtAbsoluteUrl encoding:0x80000631  error:nil];
    }
    UITextView *textview = [[UITextView alloc]initWithFrame:self.view.bounds];
    textview.text = txt;
    [self.view addSubview:textview];
    [self.view bringSubviewToFront:self.backBtn];
    // Do any additional setup after loading the view from its nib.
}

//- (void)GoBack:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//    NSLog(@"----------%@",self.navigationController.viewControllers);
//    
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"---%@",self.view);
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
