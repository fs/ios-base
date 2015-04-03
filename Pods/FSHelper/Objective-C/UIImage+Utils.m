#import "UIImage+Utils.h"

#import <Accelerate/Accelerate.h>
#import <objc/runtime.h>
#import <ImageIO/ImageIO.h>


#pragma mark -
@implementation UIImage (Private)

+ (void)__createGraphicsBeginImageContextWithSize:(CGSize)size
{
    UIScreen *screen = [UIScreen mainScreen];
    if([screen respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, screen.scale);
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
}

+ (void)__clearGraphicsBeginImageContext
{
    UIGraphicsEndImageContext();
}

@end


#pragma mark -
@implementation UIImage (Utils)

//content type
+ (NSString *)contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c
            length:1];
    
    switch (c)
    {
        case 0xFF:
        {
            return @"image/jpg";
        }; break;
            
        case 0xD8:
        {
            return @"image/jpeg";
        }; break;
            
        case 0x89:
        {
            return @"image/png";
        }; break;
            
        case 0x47:
        {
            return @"image/gif";
        }; break;
            
        case 0x49:
        case 0x4D:
        {
            return @"image/tiff";
        }; break;
            
        default:
        {
            return nil;
        }; break;
    }
}

//color mask
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
{
    UIImage *img = nil;
    
    [UIImage __createGraphicsBeginImageContextWithSize:size];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    [UIImage __clearGraphicsBeginImageContext];
    
    return img;
}

+ (UIImage *)imageNamed:(NSString *)name
                  color:(UIColor *)color
{
    UIImage *resultImage = [UIImage imageNamed:name];
    
    if (color)
    {
        [self __createGraphicsBeginImageContextWithSize:resultImage.size];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGRect area = CGRectMake(0, 0, resultImage.size.width, resultImage.size.height);
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);
        CGContextSaveGState(ctx);
        CGContextClipToMask(ctx, area, resultImage.CGImage);
        [color set];
        CGContextFillRect(ctx, area);
        CGContextRestoreGState(ctx);
        CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
        CGContextDrawImage(ctx, area, resultImage.CGImage);
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        [self __clearGraphicsBeginImageContext];
    }
    
    return resultImage;
}

//croping
- (UIImage *)imageByCroppingForRect:(CGRect)targetRect
{
    [[self class] __createGraphicsBeginImageContextWithSize:targetRect.size];
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin.x = targetRect.origin.x * -1;
    thumbnailRect.origin.y = targetRect.origin.y * -1;
    thumbnailRect.size.width  = self.size.width;
    thumbnailRect.size.height = self.size.height;
    
    [self drawInRect:thumbnailRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not crop image");
    
    [[self class] __clearGraphicsBeginImageContext];
    
    return newImage;
}

//resize image
- (UIImage *)imageByScaleToSize:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
        {
            CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
        }; break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0.0f, -size.width);
            CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), self.CGImage);
        }; break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -size.height, 0.0f);
            CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), self.CGImage);
        }; break;
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
        {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -size.width, -size.height);
            CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
        }; break;
            
        default:
            break;
    }
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage: scaledImage];
    
    CGImageRelease(scaledImage);
    
    return image;
}

- (UIImage *)imageByScaleProportionalToSizeHigh:(CGSize)aSize
{
    aSize = [self sizeProportionalToSizeHigh:aSize];
    return [self imageByScaleToSize:aSize];
}

- (UIImage *)imageByScaleProportionalToSizeLow:(CGSize)aSize
{
    aSize = [self sizeProportionalToSizeLow:aSize];
    return [self imageByScaleToSize:aSize];
}

- (CGSize)sizeProportionalToSizeLow:(CGSize)aSize
{
    if (self.size.width > self.size.height)
    {
        aSize = CGSizeMake((self.size.width/self.size.height) * aSize.height, aSize.height);
    } else {
        aSize = CGSizeMake(aSize.width, (self.size.height/self.size.width) * aSize.width);
    }
    return aSize;
}

- (CGSize)sizeProportionalToSizeHigh:(CGSize)aSize
{
    if (self.size.width < self.size.height)
    {
        aSize = CGSizeMake((self.size.width/self.size.height) * aSize.height, aSize.height);
    } else {
        aSize = CGSizeMake(aSize.width, (self.size.height/self.size.width) * aSize.width);
    }
    return aSize;
}

@end


#pragma amrk -
@implementation UIImage (Union)

+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                        firstAlpha:(double)fAlpha
                         firstRect:(CGRect)fRect
                     toSecondImage:(UIImage *)sImage
                       secondAlpha:(double)sAlpha
                        secondRect:(CGRect)sRect
                        resultSize:(CGSize)rSize
{
    [self __createGraphicsBeginImageContextWithSize:rSize];
    
    [sImage drawInRect:sRect blendMode:kCGBlendModeNormal alpha:sAlpha];
    [fImage drawInRect:fRect blendMode:kCGBlendModeNormal alpha:fAlpha];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    [self __clearGraphicsBeginImageContext];
    
    return result;
}

+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                        firstAlpha:(double)fAlpha
                     toSecondImage:(UIImage *)sImage
                       secondAlpha:(double)sAlpha
                        resultSize:(CGSize)rSize
{
    return [self combinationFirstImage:fImage
                            firstAlpha:fAlpha
                             firstRect:CGRectMake(0.0f, 0.0f, fImage.size.width, fImage.size.height)
                         toSecondImage:sImage
                           secondAlpha:sAlpha
                            secondRect:CGRectMake(0.0f, 0.0f, sImage.size.width, sImage.size.height)
                            resultSize:rSize];
}

+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                     toSecondImage:(UIImage *)sImage
                        resultSize:(CGSize)rSize
{
    return [self combinationFirstImage:fImage
                            firstAlpha:1.0f
                         toSecondImage:sImage
                           secondAlpha:1.0f
                            resultSize:rSize];
}

+ (UIImage *)combinationImages:(NSArray *)images
                          rect:(NSArray *)rect
                         alpha:(NSArray *)alpha
                    resultSize:(CGSize)resSize
{
    UIImage *imageResult = nil;
    if (images.count && rect.count && alpha.count)
    {
        NSUInteger count = images.count;
        [self __createGraphicsBeginImageContextWithSize:resSize];
        for (int i = 0; i < count; i++)
        {
            UIImage *imageCurrent = [images objectAtIndex:i];
            
            CGRect rectCurrent = CGRectNull;
            NSValue *valueSecond = [rect objectAtIndex:i];
            [valueSecond getValue:&rectCurrent];
            
            CGFloat alphaCurrent = [[alpha objectAtIndex:i] doubleValue];
            
            [imageCurrent drawInRect:rectCurrent blendMode:kCGBlendModeNormal alpha:alphaCurrent];
        }
        imageResult = UIGraphicsGetImageFromCurrentImageContext();
        [self __clearGraphicsBeginImageContext];
    }
    return imageResult;
}

+ (UIImage *)combinationImages:(NSArray *)images
                          rect:(NSArray *)rect
                    resultSize:(CGSize)resSize
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:images.count];
    for (int i = 0; i < images.count; i++)
    {
        [array addObject:@1.0f];
    }
    return [UIImage combinationImages:images rect:rect alpha:[array copy] resultSize:resSize];
}

@end


#pragma mark -
@implementation UIImage (Text)

- (UIImage *)imageWithText:(NSString *)text
                      font:(UIFont *)font
                     color:(UIColor *)color
                  position:(FSTextPosition)position
{
    return [self imageWithText:text
                          font:font
                         color:color
                      position:position
                        offset:CGPointZero];
}

- (UIImage *)imageWithText:(NSString *)text
                      font:(UIFont *)font
                     color:(UIColor *)color
                  position:(FSTextPosition)position
                    offset:(CGPoint)offset
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize sizeCountStr = [text sizeWithFont:font
                           constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
#pragma clang diagnostic pop
    CGPoint point = CGPointZero;
    
    switch (position)
    {
        case FSTextPositionAtTopLeft:
        {
            point = CGPointMake(0.0f + offset.x, 0.0f + offset.y);
        }; break;
            
        case FSTextPositionAtTopCenter:
        {
            point = CGPointMake(((self.size.width - sizeCountStr.width) * 0.5f) + offset.x, 0.0f + offset.y);
        }; break;
            
        case FSTextPositionAtTopRight:
        {
            point = CGPointMake((self.size.width - sizeCountStr.width) + offset.x, 0.0f + offset.y);
        }; break;
            
        case FSTextPositionAtMiddleLeft:
        {
            point = CGPointMake(0.0f + offset.x, ((self.size.width - sizeCountStr.width) * 0.5f) + offset.y);
        }; break;
            
        case FSTextPositionAtMiddle:
        {
            point = CGPointMake(((self.size.width - sizeCountStr.width) * 0.5f) + offset.x, ((self.size.height - sizeCountStr.height) * 0.5f) + offset.y);
        }; break;
            
        case FSTextPositionAtMiddleRight:
        {
            point = CGPointMake(0.0f + offset.x, (self.size.width - sizeCountStr.width) + offset.y);
        }; break;
            
        case FSTextPositionAtBottomLeft:
        {
            point = CGPointMake(0.0f + offset.x, (self.size.height - sizeCountStr.height) + offset.y);
        }; break;
            
        case FSTextPositionAtBottomCenter:
        {
            point = CGPointMake(((self.size.width - sizeCountStr.width) * 0.5f) + offset.x, (self.size.height - sizeCountStr.height) + offset.y);
        }; break;
            
        case FSTextPositionAtBottomRight:
        {
            point = CGPointMake((self.size.width - sizeCountStr.width) + offset.x, (self.size.height - sizeCountStr.height) + offset.y);
        }; break;
            
        default:
            break;
    }
    
    return [self imageWithText:text
                          font:font
                         color:color
                         point:point];
}

- (UIImage *)imageWithText:(NSString *)text
                      font:(UIFont *)font
                     color:(UIColor *)color
                     point:(CGPoint)point
{
    UIImage *result = nil;
    CGFloat red     = 0.0f;
    CGFloat green   = 0.0f;
    CGFloat blue    = 0.0f;
    CGFloat alpha   = 1.0f;
    
    BOOL isConverted = [color getRed:&red
                               green:&green
                                blue:&blue
                               alpha:&alpha];
    if (!isConverted)
    {
        NSLog(@"Could not get the color scheme! Use [UIColor colorWithRed:green:blue:alpha:]");
    }
    else
    {
        [[self class] __createGraphicsBeginImageContextWithSize:self.size];
        [self drawAtPoint: CGPointZero];
        
        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), red, green, blue, alpha);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [text drawAtPoint:point
                 withFont:font];
#pragma clang diagnostic pop
        result = UIGraphicsGetImageFromCurrentImageContext();
        
        [[self class] __clearGraphicsBeginImageContext];
    }
    
    return result;
}

@end


#pragma mark -
@implementation UIImage (GIF)

#if __has_feature(objc_arc)
    #define toCF (__bridge CFTypeRef)
    #define fromCF (__bridge id)
#else
    #define toCF (CFTypeRef)
    #define fromCF (id)
#endif

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = fromCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                // Even though the GIF stores the delay as an integer number of centiseconds, ImageIO “helpfully” converts that to seconds for us.
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b)
        return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0)
            return b;
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        // Note that after I process the first few elements of the vector, `gcd` will probably be smaller than any remaining element.  By passing the smaller value as the second argument to `pairGCD`, I avoid making it swap the arguments.
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(toCF data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(toCF url, NULL));
}

@end


#pragma mark -
@implementation UIImage (ContentMode)

- (void)drawInRect:(CGRect)rect
       contentMode:(UIViewContentMode)contentMode
{
    BOOL clip = NO;
    CGRect originalRect = rect;
    if (self.size.width != rect.size.width || self.size.height != rect.size.height)
    {
        clip = (contentMode != UIViewContentModeScaleAspectFill && contentMode != UIViewContentModeScaleAspectFit);
        rect = [self convertRect:rect withContentMode:contentMode];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (clip) {
        CGContextSaveGState(context);
        CGContextAddRect(context, originalRect);
        CGContextClip(context);
    }
    
    [self drawInRect:rect];
    
    if (clip)
    {
        CGContextRestoreGState(context);
    }
}

- (CGRect)convertRect:(CGRect)rect
      withContentMode:(UIViewContentMode)contentMode
{
    if (self.size.width != rect.size.width || self.size.height != rect.size.height)
    {
        if (contentMode == UIViewContentModeLeft)
        {
            return CGRectMake(rect.origin.x,
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeRight)
        {
            return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeTop)
        {
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y,
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeBottom)
        {
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y + floor(rect.size.height - self.size.height),
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeCenter)
        {
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeBottomLeft)
        {
            return CGRectMake(rect.origin.x,
                              rect.origin.y + floor(rect.size.height - self.size.height),
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeBottomRight)
        {
            return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y + (rect.size.height - self.size.height),
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeTopLeft)
        {
            return CGRectMake(rect.origin.x,
                              rect.origin.y,
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeTopRight)
        {
            return CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y,
                              self.size.width,
                              self.size.height);
        }
        else if (contentMode == UIViewContentModeScaleAspectFill)
        {
            CGSize imageSize = self.size;
            if (imageSize.height < imageSize.width)
            {
                imageSize.width  = floor((imageSize.width/imageSize.height) * rect.size.height);
                imageSize.height = rect.size.height;
            }
            else
            {
                imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
                imageSize.width  = rect.size.width;
            }
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                              rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                              imageSize.width,
                              imageSize.height);
        }
        else if (contentMode == UIViewContentModeScaleAspectFit)
        {
            CGSize imageSize = self.size;
            if (imageSize.height < imageSize.width)
            {
                imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
                imageSize.width  = rect.size.width;
            }
            else
            {
                imageSize.width  = floor((imageSize.width/imageSize.height) * rect.size.height);
                imageSize.height = rect.size.height;
            }
            return CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                              rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                              imageSize.width,
                              imageSize.height);
        }
    }
    
    return rect;
}

@end


#pragma mark -
@implementation UIImage (Effects)

- (UIImage *)imageByLigthEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    return [self imageByBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)imageByExtraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self imageByBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)imageByDarkEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self imageByBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)imageByTintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    int componentCount = (int)CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self imageByBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}

- (UIImage *)imageByBlurWithRadius:(CGFloat)blurRadius
                         tintColor:(UIColor *)tintColor
             saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                         maskImage:(UIImage *)maskImage
{
    // check pre-conditions
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // set up output context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // draw base image
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // draw effect image
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // add in color tint
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // output image is ready
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end


