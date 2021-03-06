//
//  tmdbDetailViewController.m
//  ignotum
//
//  Created by [T.T.S.D.] on 2018-03-10.
//  Copyright © 2018 GWEB. All rights reserved.
//

#import <Foundation/Foundation.h>
//not used anymore.
#import "tmdbDetailViewController.h"

@interface tmdbDetailViewController (){
    NSMutableString *baseUrl;
    NSMutableString *posterUrl;
    NSMutableString *key;
    NSString *title;
    NSMutableString *baseImgUrl;
    NSMutableString *movieInfo;
    NSString *credits;
    NSMutableArray *listOfActors;
    NSCache *memoryCache;
    NSMutableDictionary *castDictionary;
    NSMutableArray *genresArray;
    NSMutableString *listOfGenres;
    NSMutableArray *production_companiesArray;
    NSMutableString *listOfProductionCompanies;
    NSArray *languagesArray;
    NSMutableString *listOfLanguages;
}
- (void)configureView;

@end

@implementation tmdbDetailViewController

#pragma mark - Managing the detail item


//left
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    self.title = _detailTitle;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dateLabel.text = self.release_segue;
    self.ratingLabel.text = self.rating_segue;
    
    listOfGenres = [NSMutableString stringWithString:@""];
    listOfLanguages = [NSMutableString stringWithString:@""];
    castDictionary = [[NSMutableDictionary alloc] init];
    languagesArray = [[NSMutableArray alloc]init];
    production_companiesArray = [[NSMutableArray alloc]init];
    listOfProductionCompanies = [NSMutableString stringWithString:@"" ];
    genresArray = [[NSMutableArray alloc]init];
    credits = @"/credits";
    NSString *idOfMovie = self.detailItem;
    
    NSMutableString *jsonUrl = [NSMutableString stringWithString:@"https://api.themoviedb.org/3/movie/"];
    key = [NSMutableString stringWithString:@"?api_key=457b46b19f193582f05593926582b44f"];
    [jsonUrl appendString:idOfMovie.description ];
    [jsonUrl appendString:key];
    
    
    //loading animation
    [self.scroller setHidden:NO];
    [self.downloadedView setHidden:YES];
    [self.scroller startAnimating];
    
    //async using queue
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *url=[NSURL URLWithString:jsonUrl];
        NSData *data=[NSData dataWithContentsOfURL:url];
        NSError *error=nil;
        id responseObject;
        responseObject=[NSJSONSerialization JSONObjectWithData:data options:
                        NSJSONReadingMutableContainers error:&error];
        baseImgUrl = [NSMutableString stringWithString:@"https://image.tmdb.org/t/p/w342//"];
        
        title = [responseObject objectForKey:@"title"];
        genresArray = [responseObject objectForKey:@"genres"];
        production_companiesArray = [responseObject objectForKey:@"production_companies"];
        languagesArray = [responseObject objectForKey:@"spoken_languages"];
        int i=0;
        for( i =0 ; i < languagesArray.count; i++){
            [listOfLanguages appendString: [languagesArray[i] objectForKey:@"name"]];
            if(i!= ([languagesArray count]-1) )
                [listOfLanguages appendString: @"," ];
        }
        
        
        for(i =0 ; i < genresArray.count; i++){
            [listOfGenres appendString: [genresArray[i] objectForKey:@"name"] ];
            if(i!= ([genresArray count]-1) )
                [listOfGenres appendString: @","];
        }
        
        for(i =0 ; i < production_companiesArray.count; i++){
            [listOfProductionCompanies appendString: [production_companiesArray[i] objectForKey:@"name"] ];
            if(i!= ([genresArray count]-1) )
                [listOfProductionCompanies appendString: @","];
        }
        
        NSString *suffix =[responseObject objectForKey:@"poster_path"];
        if(![suffix isEqual:[NSNull null]])
            [baseImgUrl appendString:suffix];
        
        NSData *downloadedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseImgUrl]];
        
        if (downloadedData) {
            // caching
            [memoryCache setObject:downloadedData forKey:baseImgUrl];
            
            baseUrl = [NSMutableString stringWithString:@"https://api.themoviedb.org/3/movie/"];
            [baseUrl appendString:idOfMovie.description ];
            [baseUrl appendString:credits];
            [baseUrl appendString:key];
            
            url=[NSURL URLWithString:baseUrl];
            data=[NSData dataWithContentsOfURL:url];
            
            error=nil;
            id response=[NSJSONSerialization JSONObjectWithData:data options:
                         NSJSONReadingMutableContainers error:&error];
            listOfActors = [response objectForKey:@"cast"]; //2
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *movieImage = [UIImage imageWithData:downloadedData];
            self.poster.image = movieImage;
            self.synopsis.text = [responseObject objectForKey:@"overview"];
            
            if(![self.synopsis.text isEqual:[NSNull null]]){
                [self.synopsis sizeToFit];
                
                if(self.synopsis.frame.size.height < self.synopsisHeight.constant){
                    self.synopsisHeight.constant = self.synopsis.frame.size.height;
                }
            }
            
            self.titleLabel.text = [responseObject objectForKey:@"title"];
            self.productionLabel.text = listOfProductionCompanies;
            self.genresLabel.text = listOfGenres;
            self.languageLabel.text = listOfLanguages;
            
            [self.scroller setHidden:YES];
            [self.downloadedView setHidden:NO];
            [self.scroller stopAnimating];
            
        });
        
    });
    
    //credits table
    baseUrl = [NSMutableString stringWithString:@"https://api.themoviedb.org/3/movie/"];
    [baseUrl appendString:idOfMovie.description ];
    [baseUrl appendString:credits];
    [baseUrl appendString:key];
    
    NSURL *url=[NSURL URLWithString:baseUrl];
    NSData *data=[NSData dataWithContentsOfURL:url];
    NSError *error =nil;
    id response=[NSJSONSerialization JSONObjectWithData:data options:
                 NSJSONReadingMutableContainers error:&error];
    listOfActors = [response objectForKey:@"cast"]; //2
    [self configureView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfActors.count;
}
int count =1;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    count++;
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    cell.imageView.image= nil;
    if(!cell)
    {
        NSLog(@"Cell is nil");
    }
    
    cell.textLabel.text = [[listOfActors objectAtIndex: [indexPath row]] objectForKey:@"name"];
    cell.detailTextLabel.text = [[listOfActors objectAtIndex: [indexPath row]] objectForKey:@"character"];
    
    NSString *cast_image_path = [[listOfActors objectAtIndex: [indexPath row]] objectForKey:@"profile_path"];
    baseImgUrl = [NSMutableString stringWithString:@"https://image.tmdb.org/t/p/w45"];
    if(![cast_image_path isEqual:[NSNull null]]){
        UIImage *checkForImage = [castDictionary objectForKey:indexPath];
        if(checkForImage){
            cell.imageView.image= checkForImage;
        }
        else {
            [baseImgUrl appendString:cast_image_path];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSURL * urlImage=[NSURL URLWithString:baseImgUrl];
                NSData *imagedata =[NSData dataWithContentsOfURL:urlImage];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(imagedata){
                        UITableViewCell *newCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath];
                        UIImage *castImage = [UIImage imageWithData:imagedata];
                        newCell.imageView.image = castImage;
                        
                        [cell setNeedsLayout];
                        if(castImage)
                            [castDictionary setObject:castImage forKey:indexPath];
                    }
                });
            });
            
        }
    }
    
    else{
        UIImage *defaultImage = [UIImage imageNamed: @"images-3.jpeg"];
        [castDictionary setObject:defaultImage forKey:indexPath];
        [cell.imageView setImage:defaultImage];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [listOfActors removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}
@end
