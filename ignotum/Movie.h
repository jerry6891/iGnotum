//
//  Movie.h
//  ignotum
//
//  Created by [T.T.S.D.] on 2018-03-10.
//  Copyright © 2018 GWEB. All rights reserved.
//
#import <UIKit/UIKit.h>
#ifndef Movie_h
#define Movie_h
#endif /* Movie_h */
#import <Foundation/Foundation.h>

@interface Movie : NSObject
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *rating;
@property (nonatomic, readwrite) NSString *posterUrl;
@property (nonatomic, readwrite) NSString *releaseDate;
@property (nonatomic, readwrite) NSString *synopsis;
@property (nonatomic, readwrite) NSString *genre;
@property (nonatomic, readwrite) NSString *language;
@property (nonatomic, readwrite) NSString *production;
@property (nonatomic, readwrite) NSString *id;

- (Movie*) createMovieObjectFromJson : (NSDictionary*) results;

@end
