//
//  ViewController.m
//

#import "ViewController.h"
#import "FSDate.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *labelView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    __weak typeof(self) wself   = self;
    [FSDate API_getCurrentDateWithCompletion:^(AFHTTPRequestOperation *operation, FSDate *date)
    {
        if (wself)
        {
            typeof(self) sself      = wself;
            sself.labelView.text    = [date formattedString];
        }
    }
                                      failed:^(AFHTTPRequestOperation *operation, NSError *error, BOOL isCancelled)
    {
        if (wself)
        {
            typeof(self) sself      = wself;
            
            NSString *text          = nil;
            if (isCancelled)
            {
                text                = @"Cancelled";
            }
            else
            {
                text                = [error localizedDescription];
            }
            sself.labelView.text    = text;
        }
    }];
}

@end
