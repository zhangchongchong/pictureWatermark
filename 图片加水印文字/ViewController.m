//
//  ViewController.m
//  图片加水印文字
//
//  Created by 张冲 on 2018/6/21.
//  Copyright © 2018年 张冲. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1222.jpg"]];
    [imageView setFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:imageView];

    UIButton *LabelButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 340, 100, 50)];
    [LabelButton setTitle:@"加文字" forState:UIControlStateNormal];
    [LabelButton setBackgroundColor:[UIColor redColor]];
    [LabelButton addTarget:self action:@selector(labelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LabelButton];

    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 400, 100, 50)];
    [imageButton setTitle:@"加图片" forState:UIControlStateNormal];
    [imageButton setBackgroundColor:[UIColor yellowColor]];
    [imageButton addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:imageButton];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)labelBtnClick:(UIButton *)btn{
    UIImage *image = [self jx_WaterImageWithImage:imageView.image text:@"这是一个文字自己是大数据快点哈婶的" textPoint:CGPointMake(600, 280) attributedString:@{NSFontAttributeName:[UIFont systemFontOfSize:30.0],//字体
                                                                                                                                    NSForegroundColorAttributeName:[UIColor redColor]}];

    imageView.image = image;
}

- (void)imageBtnClick:(UIButton *)btn{
    UIImage *image = [self addImageLogo:imageView.image text:[UIImage imageNamed:@"123.jpg"]];
    imageView.image = image;
}
- (UIImage *)jx_WaterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}


//-(UIImage *)addText:(UIImage *)img text:(NSString *)text1
//{
//    //get image width and height
//    int w = img.size.width;
//    int h = img.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    //create a graphic context with CGBitmapContextCreate
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
//    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
//    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);
//    CGContextSetTextDrawingMode(context, kCGTextFill);
//    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
//    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));
//    //Create image ref from the context
//    CGContextShowGlyphsAtPoint(context,w/2-strlen(text)*5,,strlen(text))
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
//}
-(UIImage *)addImageLogo:(UIImage *)img text:(UIImage *)logo
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(100,120, 100, logoHeight/2), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
