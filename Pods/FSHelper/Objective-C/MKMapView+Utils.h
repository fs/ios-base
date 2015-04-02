#import <MapKit/MapKit.h>


#pragma mark -
@interface MKMapView (Zoom)

@property (assign, nonatomic) NSUInteger zoomLevel;

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
