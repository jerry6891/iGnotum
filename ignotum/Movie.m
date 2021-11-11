//
//  Movie.m
//  ignotum
//
//  Created by [T.T.S.D.] on 2018-03-10.
//  Copyright © 2018 GWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@implementation Movie

- (Movie*) createMovieObjectFromJson: (NSDictionary*) results
{
    //title, date, rating, synopsis, prod, genre, language
    self.title = [results objectForKey: @"original_title"];
    self.releaseDate = [results objectForKey: @"release_date"];
    self.rating = [results objectForKey:@"vote_average"];
    self.posterUrl = [results objectForKey:@"poster_path"];
    self.synopsis = [results objectForKey:@"overview"];
    self.production = [results objectForKey:@"poster_path"];
    self.genre = [results objectForKey:@"genres"];
    self.language = [ results objectForKey:@"spoken_languages"];
    self.id = [results objectForKey:@"id"];
    return self;
}

@end
