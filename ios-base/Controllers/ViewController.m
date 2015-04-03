//
//  ViewController.m
//

#import "ViewController.h"
#import "FSDate.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UILabel *labelView;

@property (nonatomic, weak) AFHTTPRequestOperation *currentRequest;

@end

@implementation ViewController

- (IBAction)updateDate:(id)sender {
    
    __weak typeof(self) wself   = self;
    
    self.labelView.text    = NSLocalizedString(@"PLEASE_WAIT", nil);
    
    if (self.currentRequest) {
        [self.currentRequest cancel];
    }
    
    self.currentRequest     =
    [FSDate API_getCurrentDateWithCompletion:^(AFHTTPRequestOperation *operation, FSDate *date) {
         if (wself) {
             typeof(self) sself      = wself;
             sself.labelView.text    = [date formattedString];
         }
     } failed:^(AFHTTPRequestOperation *operation, NSError *error, BOOL isCancelled) {
         if (wself) {
             typeof(self) sself      = wself;
             
             if (sself.currentRequest == operation) {
                 
                 NSString *text          = nil;
                 if (isCancelled) {
                     text                = NSLocalizedString(@"CANCELLED", nil);
                 } else {
                     text                = [error localizedDescription];
                 }
                 sself.labelView.text    = text;
             }
         }
     }];
}

@end
