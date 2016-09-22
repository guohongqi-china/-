//
//  RJNetRequestTool.h


#import <Foundation/Foundation.h>

@interface RJNetRequestTool : NSObject

+ (void)PATCHWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
+ (void)PostWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
+ (void)PostWithURL:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id formdata))block success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
+ (void)GetWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
+ (void)DeleteWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
@end

