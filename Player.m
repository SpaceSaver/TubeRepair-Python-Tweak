#import "TubeRepair.h"

NSString* getVideoURL(NSString *videoID) {
    
    NSURL *videoAPIURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/youtubei/v1/player?key=AIzaSyAO_FJ2SlqU8Q4STEHLGCilw_Y9_11qcW8"]];
    
    // NSLog(@"videoAPIURL = %@", [videoAPIURL absoluteString]);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *playerRequestBody = [NSString stringWithFormat:@"{\
                                   \"context\": {\
                                       \"client\": {\
                                           \"clientName\": \"IOS\",\
                                           \"clientVersion\": \"19.16.3\"\
                                       }\
                                   },\
                                   \"videoId\": \"%@\"\
                                   }", videoID];
    [request setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 17_6_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: [playerRequestBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request setURL:videoAPIURL];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);

    NSArray *videoJSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:NULL];
    
    NSString *videoURL = [[[videoJSON valueForKey:@"streamingData"] valueForKey:@"formats"][0] valueForKey:@"url"];
    NSLog(@"Video format URL = %@", videoURL);
    return videoURL;
}
