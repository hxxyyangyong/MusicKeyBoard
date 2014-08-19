//
//  PlayMusicVCViewController.h
//  BobMusic
//
//  Created by yangyong on 14-8-13.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface PlayMusicVCViewController : UIViewController<AVAudioPlayerDelegate>
{


}
@property (nonatomic, strong) AVAudioPlayer *player;//播放器
@property (nonatomic, strong) UIButton *Playbutton;
@property (nonatomic, strong) NSArray   *musicIndexarray;
@property (nonatomic, strong) NSTimer   *timer;

@property (nonatomic, strong) NSMutableArray *playArray;

@end
