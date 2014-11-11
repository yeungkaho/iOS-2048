//
//  F3HViewController.m
//  NumberTileGame
//
//  Created by Austin Zheng on 3/22/14.
//
//

#import "F3HViewController.h"

#import "F3HNumberTileGameViewController.h"

@interface F3HViewController ()
@property (strong, nonatomic) IBOutlet UITextField *dimensionTF;
@property (strong, nonatomic) IBOutlet UITextField *targetTF;
@property (strong, nonatomic) IBOutlet UIStepper *targetStepper;
@property (strong, nonatomic) IBOutlet UISegmentedControl *swipeOrButton;
@property (nonatomic)  unsigned long long target;
@end

@implementation F3HViewController
@synthesize target = _target;

- (void)setTarget:(unsigned long long)target{
    _target = target;
    self.targetTF.text = [NSString stringWithFormat:@"%lld",_target];
}

- (IBAction)dimensionSteped:(UIStepper *)sender {
    self.targetStepper.maximumValue = sender.value*sender.value+1>=64?62:sender.value*sender.value+1;
    self.target = pow(2, self.targetStepper.value);
    self.dimensionTF.text = [NSString stringWithFormat:@"%d",(int)sender.value];
    
}
- (IBAction)targetStepped:(UIStepper *)sender {
    self.target = pow(2,sender.value);
    
}

- (IBAction)playGameButtonTapped:(id)sender {
    BOOL swipeControl;
    if ([self.swipeOrButton selectedSegmentIndex]==0) {
        swipeControl = YES;
    }else{
        swipeControl = NO;
    }
    F3HNumberTileGameViewController *c = [F3HNumberTileGameViewController numberTileGameWithDimension:[self.dimensionTF.text integerValue]
                                                                                         winThreshold:(NSUInteger)_target
                                                                                      backgroundColor:[UIColor whiteColor]
                                                                                          scoreModule:YES
                                                                                       buttonControls:!swipeControl
                                                                                        swipeControls:swipeControl];
    [self presentViewController:c animated:YES completion:nil];
}
-(void) viewDidLoad{
    [super viewDidLoad];
    _target = 2048;
    [self.targetTF setEnabled:NO];
    [self.dimensionTF setEnabled:NO];
}
@end
