
# FQ_36KeHomePage

**效果图**(ps:没有效果图,怎么看的下去)

![FQ_ScrollerVC.gif](http://upload-images.jianshu.io/upload_images/2100495-996da31fd2937768.gif?imageMogr2/auto-orient/strip)

**前言:其实是因为看到新浪微博的效果以后就写了.刚好36氪也有这个效果^-^.**

**介绍:这还是一个可以直接使用的基类控制器**
   
     -------------------下划线三种样式----------------------
       typedef enum : NSInteger{
        BottomLineTypeNone, //无下划线
        BottomLineTypeDefault = 0, //默认
        BottomLineTypeScaling, //拉伸
        }BottomLineType;


**主要三个类:**

1.配置类:`FQ_MineScrollerModel`.控制器所需的初始化数据.

     //标题数组
     @property (strong, nonatomic) NSArray *titlesArr;

     //子控制器数组
     @property (strong, nonatomic) NSArray *childVCArr;

     //下划线样式.默认:BottomLineTypeDefault
     @property (assign, nonatomic) BottomLineType lineType;

     //titleView默认颜色
     @property (strong, nonatomic) UIColor *defaultColor;

     //titleView选中颜色
     @property (strong, nonatomic) UIColor *selectColor;

     //普通下滑线的颜色
     @property (strong, nonatomic) UIColor *lineColor;

     //下滑线使用Scaling拉伸样式.渐变颜色.CGColor.或者UIColor对象.不设置则使用随机色
     @property (strong, nonatomic) NSArray *line_Scaling_colors;

     //使用拉伸时可设置线长.默认为0.随文字长度变化!一旦设置所有下划线长度均固定
     @property (assign, nonatomic) CGFloat lineLength;

2.下划线拉伸控件类:`FQ_LineColorView`.使用layer的mask实现!不断更新路径CGPath属性即可!
 核心代码如下:

    /**
    初始化控件

    @param startPoint 起始中心点
    @param startLegth 起始线长
     */
    -(void)setupStartPoint:(CGPoint)startPoint startLength:(CGFloat)startLegth
    {
       CAGradientLayer * leftColor = [CAGradientLayer layer];
    
    leftColor.frame = CGRectMake(0, 0, ScreenW, M_ScreenH);
    leftColor.startPoint = CGPointMake(0,1);
    leftColor.endPoint = CGPointMake(1,1);
    self.leftColor = leftColor;
    
    [self.layer addSublayer:leftColor];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.path moveToPoint:CGPointMake(startPoint.x - startLegth *0.5, M_ScreenH * 0.5)];
    [self.path addLineToPoint:CGPointMake(startPoint.x + startLegth * 0.5,M_ScreenH * 0.5)];
    self.path = path;
    
    CAShapeLayer * lineLayer = [CAShapeLayer layer];
    lineLayer.frame = CGRectMake(0,0, M_ScreenW, M_ScreenH);
    lineLayer.lineWidth = 10.0f;
    lineLayer.path = path.CGPath;
    lineLayer.lineCap = kCALineCapRound;
    self.lineLayer = lineLayer;
    self.layer.mask = lineLayer;
    lineLayer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    lineLayer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    
    }

3.基类控制器:`FQ_MineScrollerVC`.传入配置FQ_MineScrollerModel即可:
  
     @property (strong, nonatomic) FQ_MineScrollerModel *scrollerModel;


**使用:**

1.控制器继承自`FQ_MineScrollerVC`

    #import "FQ_MineScrollerVC.h"

    @interface ViewController : FQ_MineScrollerVC

    @end

2.属性设置:titlesArr 和  childVCArr 为必须设置项.其他均有默认值

    - (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    FQ_MineScrollerModel * scrollerModel = [[FQ_MineScrollerModel alloc]init];
    
    TestViewController * testVC1 = [[TestViewController alloc]init];
    testVC1.view.backgroundColor = [UIColor orangeColor];
    
    TestViewController * testVC2 = [[TestViewController alloc]init];
    testVC2.view.backgroundColor = [UIColor whiteColor];
    
    TestViewController * testVC3 = [[TestViewController alloc]init];
    testVC3.view.backgroundColor = [UIColor redColor];
    
    TestViewController * testVC4 = [[TestViewController alloc]init];
    testVC4.view.backgroundColor = [UIColor blueColor];
    
    TestViewController * testVC5 = [[TestViewController alloc]init];
    testVC5.view.backgroundColor = [UIColor grayColor];
    
    TestViewController * testVC6 = [[TestViewController alloc]init];
    testVC6.view.backgroundColor = [UIColor greenColor];
    
    scrollerModel.titlesArr = @[@"开始",@"历史的轨迹",@"新",@"快乐的时刻",@"信息",@"新闻时刻"];
    scrollerModel.childVCArr = @[testVC1,testVC2,testVC3,testVC4,testVC5,testVC6];
    scrollerModel.lineType = BottomLineTypeDefault;
    scrollerModel.lineLength  = 5;
    scrollerModel.line_Scaling_colors = @[(id)[UIColor cyanColor].CGColor,(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor orangeColor].CGColor,(id)[UIColor blueColor].CGColor,];
    
    self.scrollerModel = scrollerModel;

    }

END:代码比较简单!有时间再上传到github账号!现在需要源码可留言!
