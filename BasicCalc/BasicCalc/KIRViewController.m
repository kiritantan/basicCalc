//
//  KIRViewController.m
//  BasicCalc
//
//  Created by syunichi on 2014/07/23.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "KIRViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KIRViewController ()
//電卓計算用数値
@property double number;
@property double result;
//一つ前のボタンの数字を保存する
@property int temp;
//ボタンサイズ調整用数値
@property NSInteger size;
//ボタン位置調整用数値
@property int btnLocationA;
@property int btnLocationB;
@property int btnLocationC;
@property int btnLocationD;
@property int btnLocationE;
@property int btnLocation1;
@property int btnLocation2;
@property int btnLocation3;
@property int btnLocation4;
//slider
@property UISlider* slider;
//sliderの値記録用数値
@property int sliderValue;
//ボタン制御用ボタン
@property UIButton* btnUp;
@property UIButton* btnDown;
@property UIButton* btnRight;
@property UIButton* btnLeft;
@property UIButton* btnSelect;
//ボタン制御フラグ
@property int btnSelectFlag;
//ボタン
@property UIButton* btnCm;
@property UIButton* btn0;
@property UIButton* btn1;
@property UIButton* btn2;
@property UIButton* btn3;
@property UIButton* btn4;
@property UIButton* btn5;
@property UIButton* btn6;
@property UIButton* btn7;
@property UIButton* btn8;
@property UIButton* btn9;
@property UIButton* btnDot;
@property UIButton* btnAC;
@property UIButton* btnC;
@property UIButton* btnSign;
@property UIButton* btnPlus;
@property UIButton* btnMinus;
@property UIButton* btnMulti;
@property UIButton* btnDiv;
@property UIButton* btnEqual;
//結果出力label
@property UILabel *display;
//演算子出力label
@property UILabel *operatorDisplay;
//数字入力回数制御フラグ
@property NSInteger inputNumberCount;
//小数点入力フラグ
@property NSInteger dotFlag;
//小数点何桁入力か制御フラグ
@property NSInteger dotNumberFlag;
//演算子制御フラグ
@property NSInteger calcFlag;
//演算子連続押し制御フラグ
@property int operatorChangeFlag;
//モード変更制御フラグ
@property int modeChangeFlag;
//equal制御フラグ
@property int equalFlag;
//button移動制御用フラグ
@property int btnMoveFlag;
//numberSign制御用フラグ
@property int btnSignFlag;

@end

@implementation KIRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.number = 0;
    self.result = 0;
    self.size = 160;
    self.sliderValue = 160;
    self.temp = 0;
    self.btnLocationA = 200;
    self.btnLocationB = 360;
    self.btnLocationC = 520;
    self.btnLocationD = 680;
    self.btnLocationE = 840;
    self.btnLocation1 = 20;
    self.btnLocation2 = 180;
    self.btnLocation3 = 340;
    self.btnLocation4 = 500;
    self.inputNumberCount = 0;
    self.btnSelectFlag = 10;
    self.dotFlag = 0;
    self.dotNumberFlag = 0;
    self.calcFlag = 0;
    self.operatorChangeFlag = 0;
    self.modeChangeFlag = 0;
    self.equalFlag = 0;
    self.btnMoveFlag = 0;
    self.btnSignFlag = 0;
    [self setDisplay];
    [self setOperatorDisplay];
    [self setSlider];
    [self setButton0];
    [self setButton1];
    [self setButton2];
    [self setButton3];
    [self setButton4];
    [self setButton5];
    [self setButton6];
    [self setButton7];
    [self setButton8];
    [self setButton9];
    [self setButtonDot];
    [self setButtonAC];
    [self setButtonC];
    [self setButtonSign];
    [self setButtonPlus];
    [self setButtonMinus];
    [self setButtonMulti];
    [self setButtonDiv];
    [self setButtonEqual];
    [self setModeChangeButton];
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

/*display設定*/

-(void)setDisplay {
    self.display = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 728, 125)];
    self.display.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.4 alpha:0.7];
    self.display.textColor = [UIColor blackColor];
    self.display.font = [UIFont fontWithName:@"DBLCDTempBlack" size:100];
    self.display.textAlignment = UITextAlignmentRight;
    self.display.minimumFontSize = 30;
    self.display.adjustsFontSizeToFitWidth = YES;
    [[self.display layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.display layer] setBorderWidth:3.0];
    self.display.text = @"0";
    [self.view addSubview:self.display];
}

-(void)setOperatorDisplay {
    self.operatorDisplay = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 60, 60)];
    self.operatorDisplay.alpha = 1.0;
    self.operatorDisplay.textColor = [UIColor blackColor];
    [self.operatorDisplay setFont:[UIFont systemFontOfSize:50]];
    self.operatorDisplay.textAlignment = UITextAlignmentCenter;
    self.operatorDisplay.text = @"";
    
    [self.view addSubview:self.operatorDisplay];
}

/*-----mode切り替え設定-----*/

-(void)setModeChangeButton {
    self.btnCm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnCm.frame = CGRectMake(675, 200, 80, 80);
    self.btnCm.alpha = 0.7;
    [[self.btnCm layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnCm layer] setBorderWidth:3.0];
    [self.btnCm setTitle:@"change" forState:UIControlStateNormal];
    [self.btnCm.titleLabel setFont:[UIFont systemFontOfSize:20]];
    self.btnCm.backgroundColor = [UIColor blueColor];
    [self.btnCm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCm setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [self.btnCm addTarget:self action:@selector(actCm:)
        forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnCm];
}


/*-----slider設定-----*/

-(void)setSlider {
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(432, 637, 570, 30)];
    
    // 90度まわす。
    self.slider.transform = CGAffineTransformMakeRotation(M_PI * -0.5);
    
    self.slider.minimumValue = 80;
    self.slider.maximumValue = 160;
    self.slider.value        = self.sliderValue;
    [self.slider addTarget:self action:@selector(changeButtonSize:)
     forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.slider];
}

/*-----slider動作設定-----*/
-(void)changeButtonSize:(UISlider*)slider {
    self.size = slider.value;
    self.sliderValue = slider.value;
    [self setButton0];
    [self setButton1];
    [self setButton2];
    [self setButton3];
    [self setButton4];
    [self setButton5];
    [self setButton6];
    [self setButton7];
    [self setButton8];
    [self setButton9];
    [self setButtonDot];
    [self setButtonAC];
    [self setButtonC];
    [self setButtonSign];
    [self setButtonPlus];
    [self setButtonMinus];
    [self setButtonMulti];
    [self setButtonDiv];
    [self setButtonEqual];
    
}

/*-----button制御用button設定*/
-(void)setButtonUp {
    [self.btnUp  removeFromSuperview];
    self.btnUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnUp.frame = CGRectMake(560, 700, 100, 100);
    self.btnUp.alpha = 0.5;
    [[self.btnUp layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnUp layer] setBorderWidth:3.0];
    [self.btnUp setTitle:@"↑" forState:UIControlStateNormal];
    [self.btnUp.titleLabel setFont:[UIFont systemFontOfSize:90]];
    self.btnUp.backgroundColor = [UIColor blueColor];
    [self.btnUp setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnUp setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnUp addTarget:self action:@selector(actUp:)
        forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnUp];
}

-(void)setButtonDown {
    [self.btnDown  removeFromSuperview];
    self.btnDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnDown.frame = CGRectMake(560, 900, 100, 100);
    self.btnDown.alpha = 0.5;
    [[self.btnDown layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDown layer] setBorderWidth:3.0];
    [self.btnDown setTitle:@"↓" forState:UIControlStateNormal];
    [self.btnDown.titleLabel setFont:[UIFont systemFontOfSize:90]];
    self.btnDown.backgroundColor = [UIColor blueColor];
    [self.btnDown setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnDown setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnDown addTarget:self action:@selector(actDown:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnDown];
}

-(void)setButtonRight {
    [self.btnRight  removeFromSuperview];
    self.btnRight= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnRight.frame = CGRectMake(660, 800, 100, 100);
    self.btnRight.alpha = 0.5;
    [[self.btnRight layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnRight layer] setBorderWidth:3.0];
    [self.btnRight setTitle:@"→" forState:UIControlStateNormal];
    [self.btnRight.titleLabel setFont:[UIFont systemFontOfSize:90]];
    self.btnRight.backgroundColor = [UIColor blueColor];
    [self.btnRight setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnRight addTarget:self action:@selector(actRight:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnRight];
}

-(void)setButtonLeft {
    [self.btnLeft  removeFromSuperview];
    self.btnLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnLeft.frame = CGRectMake(460, 800, 100, 100);
    self.btnLeft.alpha = 0.5;
    [[self.btnLeft layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnLeft layer] setBorderWidth:3.0];
    [self.btnLeft setTitle:@"←" forState:UIControlStateNormal];
    [self.btnLeft.titleLabel setFont:[UIFont systemFontOfSize:90]];
    self.btnLeft.backgroundColor = [UIColor blueColor];
    [self.btnLeft setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnLeft addTarget:self action:@selector(actLeft:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnLeft];
}

-(void)setButtonSelect {
    [self.btnSelect  removeFromSuperview];
    self.btnSelect = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnSelect.frame = CGRectMake(560, 800, 100, 100);
    self.btnSelect.alpha = 0.5;
    [[self.btnSelect layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnSelect layer] setBorderWidth:3.0];
    [self.btnSelect setTitle:@"◎" forState:UIControlStateNormal];
    [self.btnSelect.titleLabel setFont:[UIFont systemFontOfSize:90]];
    self.btnSelect.backgroundColor = [UIColor blueColor];
    [self.btnSelect setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnSelect addTarget:self action:@selector(actSelect:)
         forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnSelect];
}

/*-----button設定-----*/

-(void)setButton0 {
    [self.btn0 removeFromSuperview];
    self.btn0 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn0.frame = CGRectMake(self.btnLocation1, self.btnLocationE, self.size*2, self.size);
    self.btn0.alpha = 0.7;
    [[self.btn0 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn0 layer] setBorderWidth:3.0];
    [self.btn0 setTitle:@"0" forState:UIControlStateNormal];
    [self.btn0.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn0.backgroundColor = [UIColor grayColor];
    [self.btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn0 addTarget:self action:@selector(act0:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn0];
    
}

-(void)setButton1 {
    [self.btn1 removeFromSuperview];
    self.btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn1.frame = CGRectMake(self.btnLocation1, self.btnLocationD, self.size, self.size);
    self.btn1.alpha = 0.7;
    [[self.btn1 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn1 layer] setBorderWidth:3.0];
    [self.btn1 setTitle:@"1" forState:UIControlStateNormal];
    [self.btn1.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn1.backgroundColor = [UIColor grayColor];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn1 addTarget:self action:@selector(act1:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn1];
    
}

-(void)setButton2 {
    [self.btn2 removeFromSuperview];
    self.btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn2.frame = CGRectMake(self.btnLocation2, self.btnLocationD, self.size, self.size);
    self.btn2.alpha = 0.7;
    [[self.btn2 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn2 layer] setBorderWidth:3.0];
    [self.btn2 setTitle:@"2" forState:UIControlStateNormal];
    [self.btn2.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn2.backgroundColor = [UIColor grayColor];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn2 addTarget:self action:@selector(act2:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn2];
    
}

-(void)setButton3 {
    [self.btn3 removeFromSuperview];
    self.btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn3.frame = CGRectMake(self.btnLocation3, self.btnLocationD, self.size, self.size);
    self.btn3.alpha = 0.7;
    [[self.btn3 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn3 layer] setBorderWidth:3.0];
    [self.btn3 setTitle:@"3" forState:UIControlStateNormal];
    [self.btn3.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn3.backgroundColor = [UIColor grayColor];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn3 addTarget:self action:@selector(act3:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn3];
    
}

-(void)setButton4 {
    [self.btn4 removeFromSuperview];
    self.btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn4.frame = CGRectMake(self.btnLocation1, self.btnLocationC, self.size, self.size);
    self.btn4.alpha = 0.7;
    [[self.btn4 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn4 layer] setBorderWidth:3.0];
    [self.btn4 setTitle:@"4" forState:UIControlStateNormal];
    [self.btn4.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn4.backgroundColor = [UIColor grayColor];
    [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn4 addTarget:self action:@selector(act4:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn4];
    
}

-(void)setButton5 {
    [self.btn5 removeFromSuperview];
    self.btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn5.frame = CGRectMake(self.btnLocation2, self.btnLocationC, self.size, self.size);
    self.btn5.alpha = 0.7;
    [[self.btn5 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn5 layer] setBorderWidth:3.0];
    [self.btn5 setTitle:@"5" forState:UIControlStateNormal];
    [self.btn5.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn5.backgroundColor = [UIColor grayColor];
    [self.btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn5 addTarget:self action:@selector(act5:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn5];
    
}

-(void)setButton6 {
    [self.btn6 removeFromSuperview];
    self.btn6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn6.frame = CGRectMake(self.btnLocation3, self.btnLocationC, self.size, self.size);
    self.btn6.alpha = 0.7;
    [[self.btn6 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn6 layer] setBorderWidth:3.0];
    [self.btn6 setTitle:@"6" forState:UIControlStateNormal];
    [self.btn6.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn6.backgroundColor = [UIColor grayColor];
    [self.btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn6 addTarget:self action:@selector(act6:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn6];
    
}

-(void)setButton7 {
    [self.btn7 removeFromSuperview];
    self.btn7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn7.frame = CGRectMake(self.btnLocation1, self.btnLocationB, self.size, self.size);
    self.btn7.alpha = 0.7;
    [[self.btn7 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn7 layer] setBorderWidth:3.0];
    [self.btn7 setTitle:@"7" forState:UIControlStateNormal];
    [self.btn7.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn7.backgroundColor = [UIColor grayColor];
    [self.btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn7 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn7 addTarget:self action:@selector(act7:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn7];
    
}

-(void)setButton8 {
    [self.btn8 removeFromSuperview];
    self.btn8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn8.frame = CGRectMake(self.btnLocation2, self.btnLocationB, self.size, self.size);
    self.btn8.alpha = 0.7;
    [[self.btn8 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn8 layer] setBorderWidth:3.0];
    [self.btn8 setTitle:@"8" forState:UIControlStateNormal];
    [self.btn8.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn8.backgroundColor = [UIColor grayColor];
    [self.btn8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn8 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn8 addTarget:self action:@selector(act8:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn8];
    
}

-(void)setButton9 {
    [self.btn9 removeFromSuperview];
    self.btn9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn9.frame = CGRectMake(self.btnLocation3
                                 , self.btnLocationB, self.size, self.size);
    self.btn9.alpha = 0.7;
    [[self.btn9 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn9 layer] setBorderWidth:3.0];
    [self.btn9 setTitle:@"9" forState:UIControlStateNormal];
    [self.btn9.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn9.backgroundColor = [UIColor grayColor];
    [self.btn9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn9 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btn9 addTarget:self action:@selector(act9:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn9];
    
}

-(void)setButtonDot {
    [self.btnDot removeFromSuperview];
    self.btnDot = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnDot.frame = CGRectMake(self.btnLocation3, self.btnLocationE, self.size, self.size);
    self.btnDot.alpha = 0.7;
    [[self.btnDot layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDot layer] setBorderWidth:3.0];
    [self.btnDot setTitle:@"." forState:UIControlStateNormal];
    [self.btnDot.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnDot.backgroundColor = [UIColor brownColor];
    [self.btnDot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnDot setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnDot addTarget:self action:@selector(actDot:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnDot];
    
}

-(void)setButtonAC {
    [self.btnAC removeFromSuperview];
    self.btnAC = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnAC.frame = CGRectMake(self.btnLocation1, self.btnLocationA, self.size, self.size);
    self.btnAC.alpha = 0.7;
    [[self.btnAC layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnAC layer] setBorderWidth:3.0];
    [self.btnAC setTitle:@"AC" forState:UIControlStateNormal];
    self.btnAC.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.btnAC.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnAC.backgroundColor = [UIColor brownColor];
    [self.btnAC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAC setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnAC addTarget:self action:@selector(actAC:)
   forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnAC];
    
}

-(void)setButtonC {
    [self.btnC removeFromSuperview];
    self.btnC = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnC.frame = CGRectMake(self.btnLocation2, self.btnLocationA, self.size, self.size);
    self.btnC.alpha = 0.7;
    [[self.btnC layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnC layer] setBorderWidth:3.0];
    [self.btnC setTitle:@"C" forState:UIControlStateNormal];
    [self.btnC.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnC.backgroundColor = [UIColor brownColor];
    [self.btnC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnC setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnC addTarget:self action:@selector(actC:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnC];
    
}

-(void)setButtonSign {
    [self.btnSign removeFromSuperview];
    self.btnSign = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnSign.frame = CGRectMake(self.btnLocation3, self.btnLocationA, self.size, self.size);
    self.btnSign.alpha = 0.7;
    [[self.btnSign layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnSign layer] setBorderWidth:3.0];
    [self.btnSign setTitle:@"±" forState:UIControlStateNormal];
    [self.btnSign.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnSign.backgroundColor = [UIColor brownColor];
    [self.btnSign setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnSign setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnSign addTarget:self action:@selector(actSign:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnSign];
    
}

-(void)setButtonPlus {
    [self.btnPlus removeFromSuperview];
    self.btnPlus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnPlus.frame = CGRectMake(self.btnLocation4, self.btnLocationD, self.size, self.size);
    self.btnPlus.alpha = 0.7;
    [[self.btnPlus layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnPlus layer] setBorderWidth:3.0];
    [self.btnPlus setTitle:@"+" forState:UIControlStateNormal];
    [self.btnPlus.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnPlus.backgroundColor = [UIColor orangeColor];
    [self.btnPlus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnPlus setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnPlus addTarget:self action:@selector(actPlus:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnPlus];
    
}

-(void)setButtonMinus {
    [self.btnMinus removeFromSuperview];
    self.self.btnMinus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnMinus.frame = CGRectMake(self.btnLocation4, self.btnLocationC, self.size, self.size);
    self.btnMinus.alpha = 0.7;
    [[self.btnMinus layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnMinus layer] setBorderWidth:3.0];
    [self.btnMinus setTitle:@"-" forState:UIControlStateNormal];
    [self.btnMinus.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnMinus.backgroundColor = [UIColor orangeColor];
    [self.btnMinus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnMinus setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnMinus addTarget:self action:@selector(actMinus:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnMinus];
    
}

-(void)setButtonMulti {
    [self.btnMulti removeFromSuperview];
    self.btnMulti = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnMulti.frame = CGRectMake(self.btnLocation4, self.btnLocationB, self.size, self.size);
    self.btnMulti.alpha = 0.7;
    [[self.btnMulti layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnMulti layer] setBorderWidth:3.0];
    [self.btnMulti setTitle:@"×" forState:UIControlStateNormal];
    [self.btnMulti.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnMulti.backgroundColor = [UIColor orangeColor];
    [self.btnMulti setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnMulti setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnMulti addTarget:self action:@selector(actMulti:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnMulti];
    
}

-(void)setButtonDiv {
    [self.btnDiv removeFromSuperview];
    self.btnDiv = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnDiv.frame = CGRectMake(self.btnLocation4, self.btnLocationA, self.size, self.size);
    self.btnDiv.alpha = 0.7;
    [[self.btnDiv layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDiv layer] setBorderWidth:3.0];
    [self.btnDiv setTitle:@"÷" forState:UIControlStateNormal];
    [self.btnDiv.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnDiv.backgroundColor = [UIColor orangeColor];
    [self.btnDiv setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnDiv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnDiv addTarget:self action:@selector(actDiv:)
    forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnDiv];
    
}

-(void)setButtonEqual {
    [self.btnEqual removeFromSuperview];
    self.btnEqual = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnEqual.frame = CGRectMake(self.btnLocation4, self.btnLocationE, self.size, self.size);
    self.btnEqual.alpha = 0.7;
    [[self.btnEqual layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnEqual layer] setBorderWidth:3.0];
    [self.btnEqual setTitle:@"=" forState:UIControlStateNormal];
    [self.btnEqual.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnEqual.backgroundColor = [UIColor orangeColor];
    [self.btnEqual setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnEqual setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.btnEqual addTarget:self action:@selector(actEqual:)
     forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btnEqual];
    
}

/*-----button動作設定-----*/

-(void)actCm:(UIButton*)btn{
    if (self.modeChangeFlag == 0){
        self.modeChangeFlag = 1;
        self.btnLocationA = 200;
        self.btnLocationB = 280;
        self.btnLocationC = 360;
        self.btnLocationD = 440;
        self.btnLocationE = 520;
        self.btnLocation1 = 20;
        self.btnLocation2 = 100;
        self.btnLocation3 = 180;
        self.btnLocation4 = 260;
        self.size = 80;
        [self.slider removeFromSuperview];
        [self setButtonUp];
        [self setButtonDown];
        [self setButtonRight];
        [self setButtonLeft];
        [self setButtonSelect];
        [self repaintButton0];
        [self repaintButton1];
        [self repaintButton2];
        [self repaintButton3];
        [self repaintButton4];
        [self repaintButton5];
        [self repaintButton6];
        [self repaintButton7];
        [self repaintButton8];
        [self repaintButton9];
        [self repaintButtonDot];
        [self repaintButtonAC];
        [self repaintButtonC];
        [self repaintButtonSign];
        [self repaintButtonPlus];
        [self repaintButtonMinus];
        [self repaintButtonMulti];
        [self repaintButtonDiv];
        [self repaintButtonEqual];
        self.btn5.backgroundColor = [UIColor greenColor];
        self.btnSelectFlag = 10;
    } else {
        self.modeChangeFlag = 0;
        self.btnLocationA = 200;
        self.btnLocationB = 360;
        self.btnLocationC = 520;
        self.btnLocationD = 680;
        self.btnLocationE = 840;
        self.btnLocation1 = 20;
        self.btnLocation2 = 180;
        self.btnLocation3 = 340;
        self.btnLocation4 = 500;
        self.size = self.sliderValue;
        [self setSlider];
        [self.btnUp removeFromSuperview];
        [self.btnDown removeFromSuperview];
        [self.btnRight removeFromSuperview];
        [self.btnLeft removeFromSuperview];
        [self.btnSelect removeFromSuperview];
        [self setButton0];
        [self setButton1];
        [self setButton2];
        [self setButton3];
        [self setButton4];
        [self setButton5];
        [self setButton6];
        [self setButton7];
        [self setButton8];
        [self setButton9];
        [self setButtonDot];
        [self setButtonAC];
        [self setButtonC];
        [self setButtonSign];
        [self setButtonPlus];
        [self setButtonMinus];
        [self setButtonMulti];
        [self setButtonDiv];
        [self setButtonEqual];
    }
}

-(void)actUp:(UIButton*)btn {
    self.btnSelectFlag -= 4;
    if (self.btnSelectFlag == 15)
        self.btnSelectFlag = 16;
    if (self.btnSelectFlag == 14)
        self.btnSelectFlag = 15;
    if (self.btnSelectFlag == -3)
        self.btnSelectFlag = 17;
    if (self.btnSelectFlag == -2)
        self.btnSelectFlag = 17;
    if (self.btnSelectFlag == -1)
        self.btnSelectFlag = 18;
    if (self.btnSelectFlag == 0)
        self.btnSelectFlag = 19;
    if (self.btnSelectFlag == 13) {
        if (self.btnMoveFlag == 2)
            self.btnSelectFlag = 14;
    }
    
    if (self.btnSelectFlag == 1 || self.btnSelectFlag == 13 || self.btnSelectFlag == 19)
        self.btnMoveFlag = 1;
    if (self.btnSelectFlag == 2 || self.btnSelectFlag == 14 || self.btnSelectFlag == 18)
        self.btnMoveFlag = 2;
    [self repaintButton0];
    [self repaintButton1];
    [self repaintButton2];
    [self repaintButton3];
    [self repaintButton4];
    [self repaintButton5];
    [self repaintButton6];
    [self repaintButton7];
    [self repaintButton8];
    [self repaintButton9];
    [self repaintButtonDot];
    [self repaintButtonAC];
    [self repaintButtonC];
    [self repaintButtonSign];
    [self repaintButtonPlus];
    [self repaintButtonMinus];
    [self repaintButtonMulti];
    [self repaintButtonDiv];
    [self repaintButtonEqual];
    
    switch (self.btnSelectFlag) {
        case 1:
            self.btnAC.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            self.btnC.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.btnSign.backgroundColor = [UIColor greenColor];
            break;
        case 4:
            self.btnDiv.backgroundColor = [UIColor greenColor];
            break;
        case 5:
            self.btn7.backgroundColor = [UIColor greenColor];
            break;
        case 6:
            self.btn8.backgroundColor = [UIColor greenColor];
            break;
        case 7:
            self.btn9.backgroundColor = [UIColor greenColor];
            break;
        case 8:
            self.btnMulti.backgroundColor = [UIColor greenColor];
            break;
        case 9:
            self.btn4.backgroundColor = [UIColor greenColor];
            break;
        case 10:
            self.btn5.backgroundColor = [UIColor greenColor];
            break;
        case 11:
            self.btn6.backgroundColor = [UIColor greenColor];
            break;
        case 12:
            self.btnMinus.backgroundColor = [UIColor greenColor];
            break;
        case 13:
            self.btn1.backgroundColor = [UIColor greenColor];
            break;
        case 14:
            self.btn2.backgroundColor = [UIColor greenColor];
            break;
        case 15:
            self.btn3.backgroundColor = [UIColor greenColor];
            break;
        case 16:
            self.btnPlus.backgroundColor = [UIColor greenColor];
            break;
        case 17:
            self.btn0.backgroundColor = [UIColor greenColor];
            break;
        case 18:
            self.btnDot.backgroundColor = [UIColor greenColor];
            break;
        case 19:
            self.btnEqual.backgroundColor = [UIColor greenColor];
            break;
        default:
            break;
    }
}

-(void)actDown:(UIButton*)btn {
    self.btnSelectFlag += 4;
    if (self.btnSelectFlag == 18)
        self.btnSelectFlag = 17;
    if (self.btnSelectFlag == 19)
        self.btnSelectFlag = 18;
    if (self.btnSelectFlag == 20)
        self.btnSelectFlag = 19;
    if (self.btnSelectFlag == 21) {
        if (self.btnMoveFlag == 1)
            self.btnSelectFlag = 1;
        if (self.btnMoveFlag == 2)
            self.btnSelectFlag =2;
    }
    if (self.btnSelectFlag == 22)
        self.btnSelectFlag = 3;
    if (self.btnSelectFlag == 23)
        self.btnSelectFlag = 4;
    
    if (self.btnSelectFlag == 1 || self.btnSelectFlag == 13 || self.btnSelectFlag == 19)
        self.btnMoveFlag = 1;
    if (self.btnSelectFlag == 2 || self.btnSelectFlag == 14 || self.btnSelectFlag == 18)
        self.btnMoveFlag = 2;

    [self repaintButton0];
    [self repaintButton1];
    [self repaintButton2];
    [self repaintButton3];
    [self repaintButton4];
    [self repaintButton5];
    [self repaintButton6];
    [self repaintButton7];
    [self repaintButton8];
    [self repaintButton9];
    [self repaintButtonDot];
    [self repaintButtonAC];
    [self repaintButtonC];
    [self repaintButtonSign];
    [self repaintButtonPlus];
    [self repaintButtonMinus];
    [self repaintButtonMulti];
    [self repaintButtonDiv];
    [self repaintButtonEqual];
    
    switch (self.btnSelectFlag) {
        case 1:
            self.btnAC.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            self.btnC.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.btnSign.backgroundColor = [UIColor greenColor];
            break;
        case 4:
            self.btnDiv.backgroundColor = [UIColor greenColor];
            break;
        case 5:
            self.btn7.backgroundColor = [UIColor greenColor];
            break;
        case 6:
            self.btn8.backgroundColor = [UIColor greenColor];
            break;
        case 7:
            self.btn9.backgroundColor = [UIColor greenColor];
            break;
        case 8:
            self.btnMulti.backgroundColor = [UIColor greenColor];
            break;
        case 9:
            self.btn4.backgroundColor = [UIColor greenColor];
            break;
        case 10:
            self.btn5.backgroundColor = [UIColor greenColor];
            break;
        case 11:
            self.btn6.backgroundColor = [UIColor greenColor];
            break;
        case 12:
            self.btnMinus.backgroundColor = [UIColor greenColor];
            break;
        case 13:
            self.btn1.backgroundColor = [UIColor greenColor];
            break;
        case 14:
            self.btn2.backgroundColor = [UIColor greenColor];
            break;
        case 15:
            self.btn3.backgroundColor = [UIColor greenColor];
            break;
        case 16:
            self.btnPlus.backgroundColor = [UIColor greenColor];
            break;
        case 17:
            self.btn0.backgroundColor = [UIColor greenColor];
            break;
        case 18:
            self.btnDot.backgroundColor = [UIColor greenColor];
            break;
        case 19:
            self.btnEqual.backgroundColor = [UIColor greenColor];
            break;
        default:
            break;
    }
}

-(void)actRight:(UIButton*)btn {
    self.btnSelectFlag += 1;
    if (self.btnSelectFlag % 4 == 1) {
        self.btnSelectFlag -= 4;
    }
    if (self.btnSelectFlag == 20) {
        self.btnSelectFlag = 17;
    }
    
    if (self.btnSelectFlag == 1 || self.btnSelectFlag == 13 || self.btnSelectFlag == 19)
        self.btnMoveFlag = 1;
    if (self.btnSelectFlag == 2 || self.btnSelectFlag == 14 || self.btnSelectFlag == 18)
        self.btnMoveFlag = 2;
    
    [self repaintButton0];
    [self repaintButton1];
    [self repaintButton2];
    [self repaintButton3];
    [self repaintButton4];
    [self repaintButton5];
    [self repaintButton6];
    [self repaintButton7];
    [self repaintButton8];
    [self repaintButton9];
    [self repaintButtonDot];
    [self repaintButtonAC];
    [self repaintButtonC];
    [self repaintButtonSign];
    [self repaintButtonPlus];
    [self repaintButtonMinus];
    [self repaintButtonMulti];
    [self repaintButtonDiv];
    [self repaintButtonEqual];
    
    switch (self.btnSelectFlag) {
        case 1:
            self.btnAC.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            self.btnC.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.btnSign.backgroundColor = [UIColor greenColor];
            break;
        case 4:
            self.btnDiv.backgroundColor = [UIColor greenColor];
            break;
        case 5:
            self.btn7.backgroundColor = [UIColor greenColor];
            break;
        case 6:
            self.btn8.backgroundColor = [UIColor greenColor];
            break;
        case 7:
            self.btn9.backgroundColor = [UIColor greenColor];
            break;
        case 8:
            self.btnMulti.backgroundColor = [UIColor greenColor];
            break;
        case 9:
            self.btn4.backgroundColor = [UIColor greenColor];
            break;
        case 10:
            self.btn5.backgroundColor = [UIColor greenColor];
            break;
        case 11:
            self.btn6.backgroundColor = [UIColor greenColor];
            break;
        case 12:
            self.btnMinus.backgroundColor = [UIColor greenColor];
            break;
        case 13:
            self.btn1.backgroundColor = [UIColor greenColor];
            break;
        case 14:
            self.btn2.backgroundColor = [UIColor greenColor];
            break;
        case 15:
            self.btn3.backgroundColor = [UIColor greenColor];
            break;
        case 16:
            self.btnPlus.backgroundColor = [UIColor greenColor];
            break;
        case 17:
            self.btn0.backgroundColor = [UIColor greenColor];
            break;
        case 18:
            self.btnDot.backgroundColor = [UIColor greenColor];
            break;
        case 19:
            self.btnEqual.backgroundColor = [UIColor greenColor];
            break;
        default:
            break;
    }
}

-(void)actLeft:(UIButton*)btn {
    self.btnSelectFlag -= 1;
    if (self.btnSelectFlag % 4 == 0) {
        self.btnSelectFlag += 4;
    }
    if (self.btnSelectFlag == 20) {
        self.btnSelectFlag = 19;
    }
    
    if (self.btnSelectFlag == 1 || self.btnSelectFlag == 13 || self.btnSelectFlag == 19)
        self.btnMoveFlag = 1;
    if (self.btnSelectFlag == 2 || self.btnSelectFlag == 14 || self.btnSelectFlag == 18)
        self.btnMoveFlag = 2;
    
    [self repaintButton0];
    [self repaintButton1];
    [self repaintButton2];
    [self repaintButton3];
    [self repaintButton4];
    [self repaintButton5];
    [self repaintButton6];
    [self repaintButton7];
    [self repaintButton8];
    [self repaintButton9];
    [self repaintButtonDot];
    [self repaintButtonAC];
    [self repaintButtonC];
    [self repaintButtonSign];
    [self repaintButtonPlus];
    [self repaintButtonMinus];
    [self repaintButtonMulti];
    [self repaintButtonDiv];
    [self repaintButtonEqual];
    
    switch (self.btnSelectFlag) {
        case 1:
            self.btnAC.backgroundColor = [UIColor greenColor];
            break;
        case 2:
            self.btnC.backgroundColor = [UIColor greenColor];
            break;
        case 3:
            self.btnSign.backgroundColor = [UIColor greenColor];
            break;
        case 4:
            self.btnDiv.backgroundColor = [UIColor greenColor];
            break;
        case 5:
            self.btn7.backgroundColor = [UIColor greenColor];
            break;
        case 6:
            self.btn8.backgroundColor = [UIColor greenColor];
            break;
        case 7:
            self.btn9.backgroundColor = [UIColor greenColor];
            break;
        case 8:
            self.btnMulti.backgroundColor = [UIColor greenColor];
            break;
        case 9:
            self.btn4.backgroundColor = [UIColor greenColor];
            break;
        case 10:
            self.btn5.backgroundColor = [UIColor greenColor];
            break;
        case 11:
            self.btn6.backgroundColor = [UIColor greenColor];
            break;
        case 12:
            self.btnMinus.backgroundColor = [UIColor greenColor];
            break;
        case 13:
            self.btn1.backgroundColor = [UIColor greenColor];
            break;
        case 14:
            self.btn2.backgroundColor = [UIColor greenColor];
            break;
        case 15:
            self.btn3.backgroundColor = [UIColor greenColor];
            break;
        case 16:
            self.btnPlus.backgroundColor = [UIColor greenColor];
            break;
        case 17:
            self.btn0.backgroundColor = [UIColor greenColor];
            break;
        case 18:
            self.btnDot.backgroundColor = [UIColor greenColor];
            break;
        case 19:
            self.btnEqual.backgroundColor = [UIColor greenColor];
            break;
        default:
            break;
    }
}

-(void)actSelect:(UIButton*)btn {
    switch (self.btnSelectFlag) {
        case 1:
            [self actAC:btn];
            break;
        case 2:
            [self actC:btn];
            break;
        case 3:
            [self actSign:btn];
            break;
        case 4:
            [self actDiv:btn];
            break;
        case 5:
            [self act7:btn];
            break;
        case 6:
            [self act8:btn];
            break;
        case 7:
            [self act9:btn];
            break;
        case 8:
            [self actMulti:btn];
            break;
        case 9:
            [self act4:btn];
            break;
        case 10:
            [self act5:btn];
            break;
        case 11:
            [self act6:btn];
            break;
        case 12:
            [self actMinus:btn];
            break;
        case 13:
            [self act1:btn];
            break;
        case 14:
            [self act2:btn];
            break;
        case 15:
            [self act3:btn];
            break;
        case 16:
            [self actPlus:btn];
            break;
        case 17:
            [self act0:btn];
            break;
        case 18:
            [self actDot:btn];
            break;
        case 19:
            [self actEqual:btn];
            break;
        default:
            break;
    }
}

-(void)act0:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    
    if (self.dotFlag != 0) {
        double num = 0;
        self.temp  = num;
        self.operatorChangeFlag = 0;
        switch (self.dotNumberFlag) {
            case 0:
                num /= 10;
                self.number += num;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                self.inputNumberCount++;
                self.dotNumberFlag++;
                break;
            case 1:
                num /= 100;
                self.number += num;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                self.inputNumberCount++;
                self.dotNumberFlag++;
                break;
            case 2:
                num /= 1000;
                self.number += num;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                self.inputNumberCount++;
                self.dotNumberFlag++;
                break;
            case 3:
                num /= 10000;
                self.number += num;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                self.inputNumberCount++;
                self.dotNumberFlag++;
                break;
            case 4:
                num /= 100000;
                self.number += num;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                self.inputNumberCount++;
                self.dotNumberFlag++;
                break;
            case 5:
                num /= 1000000;
                self.number += num;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                self.inputNumberCount++;
                self.dotNumberFlag++;
                break;
            default:
                break;
        }
    }
    
    if (self.inputNumberCount != 0) {
        double num = 0;
        self.temp  = num;
        self.operatorChangeFlag = 0;
        if (self.inputNumberCount < 6) {
            if (self.dotFlag == 0) {
                self.number *= 10;
                self.number += num;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
                self.inputNumberCount++;
            }
        }
    }
}

-(void)act1:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 1;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act2:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 2;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act3:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 3;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act4:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 4;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act5:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 5;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act6:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 6;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act7:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 7;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act8:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 8;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)act9:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    double num = 9;
    self.temp  = num;
    self.operatorChangeFlag = 0;
    if (self.inputNumberCount < 6) {
        if (self.dotFlag == 0) {
            self.number *= 10;
            self.number += num;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.number *= -1;
            }
            self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
            self.inputNumberCount++;
        } else {
            switch (self.dotNumberFlag) {
                case 0:
                    num /= 10;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 1:
                    num /= 100;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 2:
                    num /= 1000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 3:
                    num /= 10000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 4:
                    num /= 100000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                case 5:
                    num /= 1000000;
                    self.number += num;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.number *= -1;
                    }
                    self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
                    self.inputNumberCount++;
                    self.dotNumberFlag++;
                    break;
                default:
                    break;
            }
        }
    }
}

-(void)actDot:(UIButton*)btn {
    self.operatorChangeFlag = 0;
    if (self.dotFlag == 0) {
        self.dotFlag = 1;
    }
}

-(void)actAC:(UIButton*)btn {
    self.result = 0;
    self.number = 0;
    self.display.text = @"0";
    self.operatorDisplay.text = @" ";
    self.inputNumberCount = 0;
    self.dotFlag = 0;
    self.dotNumberFlag = 0;
    self.calcFlag = 0;
    self.operatorChangeFlag = 0;
}

-(void)actC:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    if (self.dotFlag == 0) {
        self.number = (int)(self.number / 10);
        if (self.btnSignFlag == 1) {
            self.btnSignFlag = 0;
        }
        self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
    } else {
        switch (self.dotNumberFlag) {
            case 0:
                self.dotFlag = 0;
                self.number = 0;
                if (self.number < 0) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
                break;
            case 1:
                self.number *= 10;
                self.number -= self.temp;
                self.number /= 10;
                self.temp = (int)self.number%10;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
                break;
            case 2:
                self.number *= 100;
                self.number -= self.temp;
                self.number /= 10;
                self.temp = (int)self.number%10;
                self.number /= 10;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                break;
            case 3:
                self.number *= 1000;
                self.number -= self.temp;
                self.number /= 10;
                self.temp = (int)self.number%10;
                self.number /= 100;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                break;
            case 4:
                self.number *= 10000;
                self.number -= self.temp;
                self.number /= 10;
                self.temp = (int)self.number%10;
                self.number /= 1000;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                break;
            case 5:
                self.number *= 100000;
                self.number -= self.temp;
                self.number /= 10;
                self.temp = (int)self.number%10;
                self.number /= 10000;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                break;
            case 6:
                self.number *= 1000000;
                self.number -= self.temp;
                self.number /= 10;
                self.temp = (int)self.number%10;
                self.number /= 100000;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.number *= -1;
                }
                self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
            default:
                break;
        }
    }
    if (self.dotNumberFlag > 0) {
        self.dotNumberFlag--;
    }
    if (self.dotNumberFlag < 0) {
        self.dotFlag = 0;
    }
    self.inputNumberCount--;
    if (self.inputNumberCount <= 0) {
        self.inputNumberCount = 0;
    }
    NSLog(@"%f", self.number);
}

-(void)actSign:(UIButton*)btn {
    if (self.number != 0) {
        self.operatorChangeFlag = 0;
        self.number *= -1;
        switch (self.dotNumberFlag) {
            case 0:
                self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.number];
                break;
            case 1:
                self.display.text = [NSString stringWithFormat:@"%.1lf", (double)self.number];
                break;
            case 2:
                self.display.text = [NSString stringWithFormat:@"%.2lf", (double)self.number];
                break;
            case 3:
                self.display.text = [NSString stringWithFormat:@"%.3lf", (double)self.number];
                break;
            case 4:
                self.display.text = [NSString stringWithFormat:@"%.4lf", (double)self.number];
                break;
            case 5:
                self.display.text = [NSString stringWithFormat:@"%.5lf", (double)self.number];
                break;
            case 6:
                self.display.text = [NSString stringWithFormat:@"%.6lf", (double)self.number];
            default:
                break;
        }
    }
}

-(void)actPlus:(UIButton*)btn {
    if (self.equalFlag == 1 && self.number != 0) {
        self.result =0;
    }
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    self.equalFlag = 0;
    if (self.operatorChangeFlag == 0) {
        switch (self.calcFlag) {
            case 0:
                self.result += self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 1:
                self.result -= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 2:
                self.result *= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 3:
                if (self.number == 0) {
                    self.display.text = @"定義不可";
                    self.result = 0;
                } else {
                    self.result /= self.number;
                    self.number = 0;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.result *= -1;
                    }
                    if (fmodf(self.result,1.0) == 0) {
                        self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                    } else {
                        self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                    }
                }
                break;
            default:
                break;
        }
        self.dotFlag  = 0;
        self.dotNumberFlag = 0;
        self.inputNumberCount = 0;
    }
    self.calcFlag = 0;
    self.operatorChangeFlag = 1;
    self.operatorDisplay.text = @"+";
}

-(void)actMinus:(UIButton*)btn {
    if (self.equalFlag == 1 && self.number != 0) {
        self.result =0;
    }
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    self.equalFlag = 0;
    if (self.operatorChangeFlag == 0) {
        switch (self.calcFlag) {
            case 0:
                self.result += self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 1:
                self.result -= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 2:
                self.result *= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 3:
                if (self.number == 0) {
                    self.display.text = @"定義不可";
                    self.result = 0;
                } else {
                    self.result /= self.number;
                    self.number = 0;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.result *= -1;
                    }
                    if (fmodf(self.result,1.0) == 0) {
                        self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                    } else {
                        self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                    }
                }
                break;
            default:
                break;
        }
        self.dotFlag  = 0;
        self.dotNumberFlag = 0;
        self.inputNumberCount = 0;
    }
    self.calcFlag = 1;
    self.operatorChangeFlag = 1;
    self.operatorDisplay.text = @"-";
}

-(void)actMulti:(UIButton*)btn {
    if (self.equalFlag == 1 && self.number != 0) {
        self.result =0;
    }
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    self.equalFlag = 0;
    if (self.number == 0 && self.equalFlag == 1) {
    }
    if (self.operatorChangeFlag == 0) {
        switch (self.calcFlag) {
            case 0:
                self.result += self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 1:
                self.result -= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 2:
                self.result *= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 3:
                if (self.number == 0) {
                    self.display.text = @"定義不可";
                    self.result = 0;
                } else {
                    self.result /= self.number;
                    self.number = 0;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.result *= -1;
                    }
                    if (fmodf(self.result,1.0) == 0) {
                        self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                    } else {
                        self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                    }
                }
                break;
            default:
                break;
        }
        self.dotFlag  = 0;
        self.dotNumberFlag = 0;
        self.inputNumberCount = 0;
    }
    self.calcFlag = 2;
    self.operatorChangeFlag = 1;
    self.operatorDisplay.text = @"×";
}

-(void)actDiv:(UIButton*)btn {
    if (self.equalFlag == 1 && self.number != 0) {
        self.result =0;
    }
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    self.equalFlag = 0;
    if (self.operatorChangeFlag == 0) {
        switch (self.calcFlag) {
            case 0:
                self.result += self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 1:
                self.result -= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 2:
                self.result *= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
                break;
            case 3:
                if (self.number == 0) {
                    self.display.text = @"定義不可";
                    self.result = 0;
                } else {
                    self.result /= self.number;
                    self.number = 0;
                    if (self.btnSignFlag == 1) {
                        self.btnSignFlag = 0;
                        self.result *= -1;
                    }
                    if (fmodf(self.result,1.0) == 0) {
                        self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                    } else {
                        self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                    }
                }
                break;
            default:
                break;
        }
        self.dotFlag  = 0;
        self.dotNumberFlag = 0;
        self.inputNumberCount = 0;
    }
    self.calcFlag = 3;
    self.operatorChangeFlag = 1;
    self.operatorDisplay.text = @"÷";
}

-(void)actEqual:(UIButton*)btn {
    if (self.number < 0) {
        self.btnSignFlag = 1;
        self.number *= -1;
    }
    switch (self.calcFlag) {
        case 0:
            self.result += self.number;
            self.number = 0;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.result *= -1;
            }
            if (fmodf(self.result,1.0) == 0) {
                self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
            } else {
                self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
            }
            break;
        case 1:
            self.result -= self.number;
            self.number = 0;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.result *= -1;
            }
            if (fmodf(self.result,1.0) == 0) {
                self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
            } else {
                self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
            }
            break;
        case 2:
            self.result *= self.number;
            self.number = 0;
            if (self.btnSignFlag == 1) {
                self.btnSignFlag = 0;
                self.result *= -1;
            }
            if (fmodf(self.result,1.0) == 0) {
                self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
            } else {
                self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
            }
            break;
        case 3:
            if (self.number == 0) {
                self.display.text = @"定義不可";
                self.result = 0;
            } else {
                self.result /= self.number;
                self.number = 0;
                if (self.btnSignFlag == 1) {
                    self.btnSignFlag = 0;
                    self.result *= -1;
                }
                if (fmodf(self.result,1.0) == 0) {
                    self.display.text = [NSString stringWithFormat:@"%.0lf", (double)self.result];
                } else {
                    self.display.text = [NSString stringWithFormat:@"%g", (double)self.result];
                }
            }
            break;
        default:
            break;
    }
    self.calcFlag = 0;
    self.dotFlag  = 0;
    self.dotNumberFlag = 0;
    self.inputNumberCount = 0;
    self.operatorChangeFlag = 0;
    self.operatorDisplay.text = @"";
    self.equalFlag = 1;
}

/*-----button再描画設定-----*/

-(void)repaintButton0 {
    [self.btn0 removeFromSuperview];
    self.btn0 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn0.frame = CGRectMake(self.btnLocation1, self.btnLocationE, self.size*2, self.size);
    self.btn0.alpha = 0.7;
    [[self.btn0 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn0 layer] setBorderWidth:3.0];
    [self.btn0 setTitle:@"0" forState:UIControlStateNormal];
    [self.btn0.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn0.backgroundColor = [UIColor grayColor];
    [self.btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn0 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn0 addTarget:self action:@selector(act0:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn0];
    
}

-(void)repaintButton1 {
    [self.btn1 removeFromSuperview];
    self.btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn1.frame = CGRectMake(self.btnLocation1, self.btnLocationD, self.size, self.size);
    self.btn1.alpha = 0.7;
    [[self.btn1 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn1 layer] setBorderWidth:3.0];
    [self.btn1 setTitle:@"1" forState:UIControlStateNormal];
    [self.btn1.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn1.backgroundColor = [UIColor grayColor];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn1 addTarget:self action:@selector(act1:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn1];
    
}

-(void)repaintButton2 {
    [self.btn2 removeFromSuperview];
    self.btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn2.frame = CGRectMake(self.btnLocation2, self.btnLocationD, self.size, self.size);
    self.btn2.alpha = 0.7;
    [[self.btn2 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn2 layer] setBorderWidth:3.0];
    [self.btn2 setTitle:@"2" forState:UIControlStateNormal];
    [self.btn2.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn2.backgroundColor = [UIColor grayColor];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn2 addTarget:self action:@selector(act2:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn2];
    
}

-(void)repaintButton3 {
    [self.btn3 removeFromSuperview];
    self.btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn3.frame = CGRectMake(self.btnLocation3, self.btnLocationD, self.size, self.size);
    self.btn3.alpha = 0.7;
    [[self.btn3 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn3 layer] setBorderWidth:3.0];
    [self.btn3 setTitle:@"3" forState:UIControlStateNormal];
    [self.btn3.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn3.backgroundColor = [UIColor grayColor];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn3 addTarget:self action:@selector(act3:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn3];
    
}

-(void)repaintButton4 {
    [self.btn4 removeFromSuperview];
    self.btn4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn4.frame = CGRectMake(self.btnLocation1, self.btnLocationC, self.size, self.size);
    self.btn4.alpha = 0.7;
    [[self.btn4 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn4 layer] setBorderWidth:3.0];
    [self.btn4 setTitle:@"4" forState:UIControlStateNormal];
    [self.btn4.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn4.backgroundColor = [UIColor grayColor];
    [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn4 addTarget:self action:@selector(act4:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn4];
    
}

-(void)repaintButton5 {
    [self.btn5 removeFromSuperview];
    self.btn5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn5.frame = CGRectMake(self.btnLocation2, self.btnLocationC, self.size, self.size);
    self.btn5.alpha = 0.7;
    [[self.btn5 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn5 layer] setBorderWidth:3.0];
    [self.btn5 setTitle:@"5" forState:UIControlStateNormal];
    [self.btn5.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn5.backgroundColor = [UIColor grayColor];
    [self.btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn5 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn5 addTarget:self action:@selector(act5:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn5];
    
}

-(void)repaintButton6 {
    [self.btn6 removeFromSuperview];
    self.btn6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn6.frame = CGRectMake(self.btnLocation3, self.btnLocationC, self.size, self.size);
    self.btn6.alpha = 0.7;
    [[self.btn6 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn6 layer] setBorderWidth:3.0];
    [self.btn6 setTitle:@"6" forState:UIControlStateNormal];
    [self.btn6.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn6.backgroundColor = [UIColor grayColor];
    [self.btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn6 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn6 addTarget:self action:@selector(act6:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn6];
    
}

-(void)repaintButton7 {
    [self.btn7 removeFromSuperview];
    self.btn7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn7.frame = CGRectMake(self.btnLocation1, self.btnLocationB, self.size, self.size);
    self.btn7.alpha = 0.7;
    [[self.btn7 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn7 layer] setBorderWidth:3.0];
    [self.btn7 setTitle:@"7" forState:UIControlStateNormal];
    [self.btn7.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn7.backgroundColor = [UIColor grayColor];
    [self.btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn7 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn7 addTarget:self action:@selector(act7:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn7];
    
}

-(void)repaintButton8 {
    [self.btn8 removeFromSuperview];
    self.btn8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn8.frame = CGRectMake(self.btnLocation2, self.btnLocationB, self.size, self.size);
    self.btn8.alpha = 0.7;
    [[self.btn8 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn8 layer] setBorderWidth:3.0];
    [self.btn8 setTitle:@"8" forState:UIControlStateNormal];
    [self.btn8.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn8.backgroundColor = [UIColor grayColor];
    [self.btn8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn8 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn8 addTarget:self action:@selector(act8:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn8];
    
}

-(void)repaintButton9 {
    [self.btn9 removeFromSuperview];
    self.btn9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btn9.frame = CGRectMake(self.btnLocation3
                                 , self.btnLocationB, self.size, self.size);
    self.btn9.alpha = 0.7;
    [[self.btn9 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btn9 layer] setBorderWidth:3.0];
    [self.btn9 setTitle:@"9" forState:UIControlStateNormal];
    [self.btn9.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btn9.backgroundColor = [UIColor grayColor];
    [self.btn9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn9 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btn9 addTarget:self action:@selector(act9:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btn9];
    
}

-(void)repaintButtonDot {
    [self.btnDot removeFromSuperview];
    self.btnDot = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnDot.frame = CGRectMake(self.btnLocation3, self.btnLocationE, self.size, self.size);
    self.btnDot.alpha = 0.7;
    [[self.btnDot layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDot layer] setBorderWidth:3.0];
    [self.btnDot setTitle:@"." forState:UIControlStateNormal];
    [self.btnDot.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnDot.backgroundColor = [UIColor grayColor];
    [self.btnDot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnDot setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnDot addTarget:self action:@selector(actDot:)
          forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnDot];
    
}

-(void)repaintButtonAC {
    [self.btnAC removeFromSuperview];
    self.btnAC = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnAC.frame = CGRectMake(self.btnLocation1, self.btnLocationA, self.size, self.size);
    self.btnAC.alpha = 0.7;
    [[self.btnAC layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnAC layer] setBorderWidth:3.0];
    [self.btnAC setTitle:@"AC" forState:UIControlStateNormal];
    self.btnAC.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.btnAC.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnAC.backgroundColor = [UIColor grayColor];
    [self.btnAC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnAC setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnAC addTarget:self action:@selector(actAC:)
         forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnAC];
    
}

-(void)repaintButtonC {
    [self.btnC removeFromSuperview];
    self.btnC = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnC.frame = CGRectMake(self.btnLocation2, self.btnLocationA, self.size, self.size);
    self.btnC.alpha = 0.7;
    [[self.btnC layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnC layer] setBorderWidth:3.0];
    [self.btnC setTitle:@" C " forState:UIControlStateNormal];
    self.btnC.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.btnC.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnC.backgroundColor = [UIColor grayColor];
    [self.btnC setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnC setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnC addTarget:self action:@selector(actC:)
        forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnC];
    
}

-(void)repaintButtonSign {
    [self.btnSign removeFromSuperview];
    self.btnSign = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnSign.frame = CGRectMake(self.btnLocation3, self.btnLocationA, self.size, self.size);
    self.btnSign.alpha = 0.7;
    [[self.btnSign layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnSign layer] setBorderWidth:3.0];
    [self.btnSign setTitle:@"±" forState:UIControlStateNormal];
    self.btnSign.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.btnSign.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnSign.backgroundColor = [UIColor grayColor];
    [self.btnSign setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnSign setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnSign addTarget:self action:@selector(actSign:)
           forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnSign];
    
}

-(void)repaintButtonPlus {
    [self.btnPlus removeFromSuperview];
    self.btnPlus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnPlus.frame = CGRectMake(self.btnLocation4, self.btnLocationD, self.size, self.size);
    self.btnPlus.alpha = 0.7;
    [[self.btnPlus layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnPlus layer] setBorderWidth:3.0];
    [self.btnPlus setTitle:@"+" forState:UIControlStateNormal];
    [self.btnPlus.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnPlus.backgroundColor = [UIColor grayColor];
    [self.btnPlus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnPlus setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnPlus addTarget:self action:@selector(actPlus:)
           forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnPlus];
    
}

-(void)repaintButtonMinus {
    [self.btnMinus removeFromSuperview];
    self.self.btnMinus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnMinus.frame = CGRectMake(self.btnLocation4, self.btnLocationC, self.size, self.size);
    self.btnMinus.alpha = 0.7;
    [[self.btnMinus layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnMinus layer] setBorderWidth:3.0];
    [self.btnMinus setTitle:@"-" forState:UIControlStateNormal];
    [self.btnMinus.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnMinus.backgroundColor = [UIColor grayColor];
    [self.btnMinus setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnMinus setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnMinus addTarget:self action:@selector(actMinus:)
            forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnMinus];
    
}

-(void)repaintButtonMulti {
    [self.btnMulti removeFromSuperview];
    self.btnMulti = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnMulti.frame = CGRectMake(self.btnLocation4, self.btnLocationB, self.size, self.size);
    self.btnMulti.alpha = 0.7;
    [[self.btnMulti layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnMulti layer] setBorderWidth:3.0];
    [self.btnMulti setTitle:@"×" forState:UIControlStateNormal];
    [self.btnMulti.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnMulti.backgroundColor = [UIColor grayColor];
    [self.btnMulti setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnMulti setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnMulti addTarget:self action:@selector(actMulti:)
            forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnMulti];
    
}

-(void)repaintButtonDiv {
    [self.btnDiv removeFromSuperview];
    self.btnDiv = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnDiv.frame = CGRectMake(self.btnLocation4, self.btnLocationA, self.size, self.size);
    self.btnDiv.alpha = 0.7;
    [[self.btnDiv layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDiv layer] setBorderWidth:3.0];
    [self.btnDiv setTitle:@"÷" forState:UIControlStateNormal];
    [self.btnDiv.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnDiv.backgroundColor = [UIColor grayColor];
    [self.btnDiv setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnDiv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnDiv addTarget:self action:@selector(actDiv:)
          forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnDiv];
    
}

-(void)repaintButtonEqual {
    [self.btnEqual  removeFromSuperview];
    self.btnEqual = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnEqual.frame = CGRectMake(self.btnLocation4, self.btnLocationE, self.size, self.size);
    self.btnEqual.alpha = 0.7;
    [[self.btnEqual layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnEqual layer] setBorderWidth:3.0];
    [self.btnEqual setTitle:@"=" forState:UIControlStateNormal];
    [self.btnEqual.titleLabel setFont:[UIFont systemFontOfSize:100]];
    self.btnEqual.backgroundColor = [UIColor grayColor];
    [self.btnEqual setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btnEqual setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    if (self.modeChangeFlag == 0) {
    [self.btnEqual addTarget:self action:@selector(actEqual:)
            forControlEvents:UIControlEventTouchDown];
    }
    [self.view addSubview:self.btnEqual];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
