#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FSTextPosition)
{
    FSTextPositionAtTopLeft,
    FSTextPositionAtTopCenter,
    FSTextPositionAtTopRight,
    FSTextPositionAtMiddleLeft,
    FSTextPositionAtMiddle,
    FSTextPositionAtMiddleRight,
    FSTextPositionAtBottomLeft,
    FSTextPositionAtBottomCenter,
    FSTextPositionAtBottomRight,
};

#pragma mark -
@interface UIImage (Utils)

//check signature image and return MIME type
+ (NSString *)contentTypeForImageData:(NSData *)data;

//image with color mask
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;
+ (UIImage *)imageNamed:(NSString *)name
                  color:(UIColor *)color;

//croping image
- (UIImage *)imageByCroppingForRect:(CGRect)targetRect;

//resize image
- (UIImage *)imageByScaleToSize:(CGSize)size;
- (UIImage *)imageByScaleProportionalToSizeHigh:(CGSize)aSize;
- (UIImage *)imageByScaleProportionalToSizeLow:(CGSize)aSize;

- (CGSize)sizeProportionalToSizeLow:(CGSize)aSize;
- (CGSize)sizeProportionalToSizeHigh:(CGSize)aSize;

@end


#pragma mark -
@interface UIImage (Union)

/**
 @abstract Merge two images to coordinates.
 @param combinationFirstImage image for merge (UIImage)
 @param firstAlpha alpha for first images (0.0f - 1.0f)
 @param fRect rect for overlay image (CGRect)
 @param toSecondImage image for merge UIImage
 @param secondAlpha alpha for second images (0.0f - 1.0f)
 @param secondRect rect for overlay image (CGRect)
 @param resultSize size retunring image
 @return result as UIImage
 */
+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                        firstAlpha:(double)fAlpha
                         firstRect:(CGRect)fRect
                     toSecondImage:(UIImage *)sImage
                       secondAlpha:(double)sAlpha
                        secondRect:(CGRect)sRect
                        resultSize:(CGSize)rSize;
+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                        firstAlpha:(double)fAlpha
                     toSecondImage:(UIImage *)sImage
                       secondAlpha:(double)sAlpha
                        resultSize:(CGSize)rSize;
+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                     toSecondImage:(UIImage *)sImage
                        resultSize:(CGSize)rSize;

/**
 @abstract Merge array of images to array of coordinates.
 @param images array of UIImage
 @param rect array of NSValue with CGRect
 @param alpha array of NSNumber with double from 0.0f to 1.0f
 @param resultSize size returning image
 @return return UIImage in case succes or nil if error
 */
+ (UIImage *)combinationImages:(NSArray *)images
                          rect:(NSArray *)rect
                         alpha:(NSArray *)alpha
                    resultSize:(CGSize)resSize;
+ (UIImage *)combinationImages:(NSArray *)images
                          rect:(NSArray *)rect
                    resultSize:(CGSize)resSize;

@end


#pragma mark -
@interface UIImage (Text)

- (UIImage *)imageWithText:(NSString *)text
                      font:(UIFont *)font
                     color:(UIColor *)color
                     point:(CGPoint)point;
- (UIImage *)imageWithText:(NSString *)text
                      font:(UIFont *)font
                     color:(UIColor *)color
                  position:(FSTextPosition)position;
- (UIImage *)imageWithText:(NSString *)text
                      font:(UIFont *)font
                     color:(UIColor *)color
                  position:(FSTextPosition)position
                    offset:(CGPoint)offset;

@end


#pragma mark -
//original source https://github.com/mayoff/uiimage-from-animated-gif/tree/master/uiimage-from-animated-gif
@interface UIImage (GIF)

/*
 UIImage *animation = [UIImage animatedImageWithAnimatedGIFData:theData];
 
 I interpret `theData` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
 
 The GIF stores a separate duration for each frame, in units of centiseconds (hundredths of a second).  However, a `UIImage` only has a single, total `duration` property, which is a floating-point number.
 
 To handle this mismatch, I add each source image (from the GIF) to `animation` a varying number of times to match the ratios between the frame durations in the GIF.
 
 For example, suppose the GIF contains three frames.  Frame 0 has duration 3.  Frame 1 has duration 9.  Frame 2 has duration 15.  I divide each duration by the greatest common denominator of all the durations, which is 3, and add each frame the resulting number of times.  Thus `animation` will contain frame 0 3/3 = 1 time, then frame 1 9/3 = 3 times, then frame 2 15/3 = 5 times.  I set `animation.duration` to (3+9+15)/100 = 0.27 seconds.
 */
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;

/*
 UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:theURL];
 
 I interpret the contents of `theURL` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
 
 I operate exactly like `+[UIImage animatedImageWithAnimatedGIFData:]`, except that I read the data from `theURL`.  If `theURL` is not a `file:` URL, you probably want to call me on a background thread or GCD queue to avoid blocking the main thread.
 */
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

@end


#pragma mark -
@interface UIImage (ContentMode)

- (void)drawInRect:(CGRect)rect
       contentMode:(UIViewContentMode)contentMode;
- (CGRect)convertRect:(CGRect)rect
      withContentMode:(UIViewContentMode)contentMode;

@end


#pragma mark -
@interface UIImage (Effects)

- (UIImage *)imageByLigthEffect;
- (UIImage *)imageByExtraLightEffect;
- (UIImage *)imageByDarkEffect;
- (UIImage *)imageByTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)imageByBlurWithRadius:(CGFloat)blurRadius
                         tintColor:(UIColor *)tintColor
             saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                         maskImage:(UIImage *)maskImage;

@end