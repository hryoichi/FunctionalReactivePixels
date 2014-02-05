//
//  HRYPhotoImporter.m
//  FunctionalReactivePixels
//
//  Created by Ryoichi Hara on 2014/02/04.
//  Copyright (c) 2014年 Ryoichi Hara. All rights reserved.
//

#import "HRYPhotoImporter.h"
#import "HRYPhotoModel.h"

@implementation HRYPhotoImporter

#pragma mark - Public

+ (RACReplaySubject *)importPhotos
{
    RACReplaySubject *subject = [RACReplaySubject subject];

    NSURLRequest *request = [[self class] popularURLRequest];

    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         if (data) {
             id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

             [subject sendNext:[[[results[@"photos"] rac_sequence] map: ^id(NSDictionary *photoDictionary) {
                 HRYPhotoModel *model = [HRYPhotoModel new];
                 [self configurePhotoModel:model withDictionary:photoDictionary];
                 [self downloadThumbnailForPhotoModel:model];
                 return model;
             }] array]];

             [subject sendCompleted];
         }
         else {
             [subject sendError:connectionError];
         }
     }];

    return subject;
}

#pragma mark - Private

+ (NSURLRequest *)popularURLRequest
{
    return [[PXRequest apiHelper] urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:100 page:0 photoSizes:PXPhotoModelSizeThumbnail sortOrder:PXAPIHelperSortOrderRating except:PXPhotoModelCategoryNude];
}

+ (void)configurePhotoModel:(HRYPhotoModel *)photoModel withDictionary:(NSDictionary *)dictionary
{
    photoModel.photoName = dictionary[@"name"];
    photoModel.identifier = dictionary[@"id"];
    photoModel.photographerName = dictionary[@"user"][@"username"];
    photoModel.rating = dictionary[@"rating"];
    photoModel.thumbnailURL = [self urlForImageSize:3 inArray:dictionary[@"images"]];

    if (dictionary[@"comments_count"]) {
        photoModel.fullsizedURL = [self urlForImageSize:4 inArray:dictionary[@"images"]];
    }
}

+ (NSString *)urlForImageSize:(NSInteger)size inArray:(NSArray *)array
{
    return [[[[[array rac_sequence] filter:^BOOL(NSDictionary *value) {
        return [value[@"size"] integerValue] == size;
    }] map:^id(id value) {
        return value[@"url"];
    }] array] firstObject];
}

+ (void)downloadThumbnailForPhotoModel:(HRYPhotoModel*)photoModel
{
    NSAssert(photoModel.thumbnailURL, @"Thumbnail URL must not be nil");

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:photoModel.thumbnailURL]];

    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         photoModel.thumbnailData = data;
     }];
}

@end