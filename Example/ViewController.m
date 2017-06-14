//
//  ViewController.m
//  POD_NAME_EXAMPLE
//
//  Created by Stephen Chiang on 14/06/2017.
//
//

#import "ViewController.h"
#import "ReplaceMe.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ReplaceMe *replaceMe = [[ReplaceMe alloc] init];
    
    NSLog(@"object: %@", replaceMe);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
