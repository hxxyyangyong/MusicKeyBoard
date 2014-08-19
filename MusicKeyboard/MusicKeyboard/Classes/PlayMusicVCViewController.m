//
//  PlayMusicVCViewController.m
//  BobMusic
//
//  Created by yangyong on 14-8-13.
//
//

#import "PlayMusicVCViewController.h"

@interface PlayMusicVCViewController ()

@end

static int      musicindex = 0;
static BOOL     isEnable = YES;
@implementation PlayMusicVCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ScoreFile.plist"]];
    NSString *sub215Dcit = [dict objectForKey:@"547_5"];
    _musicIndexarray = [sub215Dcit componentsSeparatedByString:@":"];
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",
                          @"7",@"8",@"9",@"*",@"0",@"#",nil];
    CGRect rect = CGRectMake(12.5, 12.5, 90, 90);
    for (int i=0; i<12; i++) {
        rect.origin.x = 12.5+i%3*102.5;
        rect.origin.y = 64+12.5+i/3*102.5;
        UIButton *playbutton = [[UIButton alloc] initWithFrame:rect];
        [playbutton.layer setCornerRadius:45];
        [playbutton setBackgroundColor:[UIColor redColor]];
        [playbutton setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
        [playbutton.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
        [playbutton addTarget:self action:@selector(playMusic) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:playbutton];
    }
    self.playArray = [[NSMutableArray alloc] init];
}

- (void)playMusic
{
    @synchronized(self){
        if (isEnable) {
            [self aaPlay];
            [self performSelector:@selector(openPlayButtonEnable) withObject:nil afterDelay:0.03];
        }
        
        
    }
}

- (void)openPlayButtonEnable
{
    isEnable = YES;
}

- (void)aaPlay
{
    
    NSString *musicPath = [_musicIndexarray objectAtIndex:musicindex];
    NSArray *amusicIndexarray = [musicPath componentsSeparatedByString:@"."];
    
    for (int i = 0; i < [amusicIndexarray count]; i++) {
        NSString *home= [NSBundle mainBundle].resourcePath;
        NSString *musicPath=[[NSString alloc]initWithFormat:@"%@/%@.mp3",home,[amusicIndexarray objectAtIndex:i],nil];
        NSURL *url=[[NSURL alloc]initFileURLWithPath:musicPath];
        if (i != 0) {
            [self performSelector:@selector(playLL:) withObject:url afterDelay:0.001];
        }else{
            [self playLL:url];
        }
        
        
    }
    musicindex++;
    if (musicindex == [_musicIndexarray count]) {
        musicindex =0;
    }

}


- (void)playLL:(NSURL *)url
{
    NSError *error=nil;
    AVAudioPlayer *player= [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [_playArray addObject:player];
    player.delegate=self;
    [player prepareToPlay];
    [player play];
}

//播放结束时执行的动作
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [_playArray removeObject:player];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
