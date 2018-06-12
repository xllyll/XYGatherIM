//
//  XYGIMChatFaceView.m
//  XYGatherIM
//
//  Created by 杨卢银 on 2018/4/9.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYGIMChatFaceView.h"
#import "SwipeView.h"
#import "XYGIMChatFacePageView.h"
#import "XYGIMFaceManager.h"

@interface XYGIMChatFaceView ()<UIScrollViewDelegate,SwipeViewDelegate,SwipeViewDataSource,XYGIMChatFacePageViewDelegate>

@property (nonatomic, strong) SwipeView *swipeView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIView *bottomView;
@property (weak, nonatomic) UIButton *sendButton;

@property (weak, nonatomic) UIButton *recentButton /**< 显示最近表情的button */;
@property (weak, nonatomic) UIButton *emojiButton /**< 显示emoji表情Button */;

@property (assign, nonatomic) NSUInteger columnPerRow; /**< 每行显示的表情数量,6,6plus可能相应多显示  默认emoji5s显示7个 最近表情显示4个  gif表情显示4个 */
@property (assign, nonatomic) NSUInteger maxRows; /**< 每页显示的行数 默认emoji3行  最近表情2行  gif表情2行 */
@property (nonatomic, assign ,readonly) NSUInteger itemsPerPage;
@property (nonatomic, assign) NSUInteger pageCount;

@property (nonatomic, strong) NSMutableArray *faceArray;
@end

@implementation XYGIMChatFaceView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - SwipeViewDelegate & SwipeViewDataSource

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    XYGIMChatFacePageView *facePageView = (XYGIMChatFacePageView *)view;
    if (!view) {
        facePageView = [[XYGIMChatFacePageView alloc] initWithFrame:swipeView.frame];
    }
    [facePageView setColumnsPerRow:self.columnPerRow];
    if ((index + 1) * self.itemsPerPage  >= self.faceArray.count) {
        [facePageView setDatas:[self.faceArray subarrayWithRange:NSMakeRange(index * self.itemsPerPage, self.faceArray.count - index * self.itemsPerPage)]];
    }else {
        [facePageView setDatas:[self.faceArray subarrayWithRange:NSMakeRange(index * self.itemsPerPage, self.itemsPerPage)]];
    }
    facePageView.delegate = self;
    return facePageView;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return self.pageCount ;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    self.pageControl.currentPage = swipeView.currentPage;
}

#pragma mark - XMNFacePageViewDelegate

- (void)selectedFaceImageWithFaceID:(NSUInteger)faceID {
    NSString *faceName = [XYGIMFaceManager faceNameWithFaceID:faceID];
    if (faceID != 999) {
        [XYGIMFaceManager saveRecentFace:@{@"face_id":[NSString stringWithFormat:@"%ld",faceID],@"face_name":faceName}];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(faceViewSendFace:)]) {
        [self.delegate faceViewSendFace:faceName];
    }
}

#pragma mark - Private Methods
-(void)reloadView{
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    _swipeView = nil;
    _pageControl = nil;
    _bottomView = nil;
    [self setup];
}
- (void)setup{
    
    [self addSubview:self.swipeView];
    [self addSubview:self.pageControl];
    [self addSubview:self.bottomView];
    
    self.faceArray = [NSMutableArray array];
    self.faceViewType = XYGIMShowEmojiFace;
    [self setupFaceView];
    
    self.userInteractionEnabled = YES;
    
}

- (void)setupFaceView{
    [self.faceArray removeAllObjects];
    if (self.faceViewType == XYGIMShowEmojiFace) {
        [self setupEmojiFaces];
    }else if (self.faceViewType == XYGIMShowRecentFace){
        [self setupRecentFaces];
    }
    [self.swipeView reloadData];
    
}

/**
 *  初始化最近使用的表情数组
 */
- (void)setupRecentFaces{
    
    self.maxRows = 2;
    self.columnPerRow = 4;
    self.pageCount = 1;
    
    [self.faceArray removeAllObjects];
    [self.faceArray addObjectsFromArray:[XYGIMFaceManager recentFaces]];
    
}

/**
 *  初始化所有的emoji表情数组,添加删除按钮
 */
- (void)setupEmojiFaces{
    
    self.maxRows = 3;
    self.columnPerRow = [UIScreen mainScreen].bounds.size.width > 320 ? 8 : 7;
    
    //计算每一页最多显示多少个表情  - 1(删除按钮)
    NSInteger pageItemCount = self.itemsPerPage - 1;
    [self.faceArray addObjectsFromArray:[XYGIMFaceManager emojiFaces]];
    //获取所有的face表情dict包含face_id,face_name两个key-value
    NSMutableArray *allFaces = [NSMutableArray arrayWithArray:[XYGIMFaceManager emojiFaces]];
    
    //计算页数
    self.pageCount = [allFaces count] % pageItemCount == 0 ? [allFaces count] / pageItemCount : ([allFaces count] / pageItemCount) + 1;
    
    //配置pageControl的页数
    self.pageControl.numberOfPages = self.pageCount;
    
    //循环,给每一页末尾加上一个delete图片,如果是最后一页直接在最后一个加上delete图片
    for (int i = 0; i < self.pageCount; i++) {
        if (self.pageCount - 1 == i) {
            [self.faceArray addObject:@{@"face_id":@"999",@"face_image_name":@"delete_icon",@"face_name":@"删除"}];
        }else{
            [self.faceArray insertObject:@{@"face_id":@"999",@"face_image_name":@"delete_icon",@"face_name":@"删除"} atIndex:(i + 1) * pageItemCount + i];
        }
    }
    
}

- (void)sendAction:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(faceViewSendFace:)]) {
        [self.delegate faceViewSendFace:@"发送"];
    }
}

- (void)changeFaceType:(UIButton *)button{
    self.faceViewType = button.tag;
    [self setupFaceView];
}

#pragma mark - Setters

- (void)setFaceViewType:(XYGIMShowFaceViewType)faceViewType {
    if (_faceViewType != faceViewType) {
        _faceViewType = faceViewType;
        self.emojiButton.selected = _faceViewType == XYGIMShowEmojiFace;
        self.recentButton.selected = _faceViewType == XYGIMShowRecentFace;
    }
}

#pragma mark - Getters

- (SwipeView *)swipeView {
    if (!_swipeView) {
        _swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 60)];
        _swipeView.delegate = self;
        _swipeView.dataSource = self;
    }
    _swipeView.frame = CGRectMake(0, 10, self.frame.size.width, self.frame.size.height - 60);
    return _swipeView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.swipeView.frame.size.height, self.frame.size.width, 20)];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
        
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 70, 1.0f)];
        topLine.backgroundColor = [UIColor lightGrayColor];
        [_bottomView addSubview:topLine];
        
        UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 0, 70, 40)];
        sendButton.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:70.0f/255.0f blue:1.0f alpha:1.0f];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:self.sendButton = sendButton];
        
        
        UIButton *recentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [recentButton setBackgroundImage:[XYGIMFaceManager imageForEmotionPNGName:@"chat_bar_recent_normal"] forState:UIControlStateNormal];
        [recentButton setBackgroundImage:[XYGIMFaceManager imageForEmotionPNGName:@"chat_bar_recent_highlight"] forState:UIControlStateHighlighted];
        [recentButton setBackgroundImage:[XYGIMFaceManager imageForEmotionPNGName:@"chat_bar_recent_highlight"] forState:UIControlStateSelected];
        recentButton.tag = XYGIMShowRecentFace;
        [recentButton addTarget:self action:@selector(changeFaceType:) forControlEvents:UIControlEventTouchUpInside];
        [recentButton sizeToFit];
        [_bottomView addSubview:self.recentButton = recentButton];
        [recentButton setFrame:CGRectMake(0, _bottomView.frame.size.height/2-recentButton.frame.size.height/2, recentButton.frame.size.width, recentButton.frame.size.height)];
        
        UIButton *jd_emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [jd_emojiButton setBackgroundImage:[XYGIMFaceManager imageForEmotionPNGName:@"chat_bar_emoji_normal"] forState:UIControlStateNormal];
        [jd_emojiButton setBackgroundImage:[XYGIMFaceManager imageForEmotionPNGName:@"chat_bar_emoji_highlight"] forState:UIControlStateHighlighted];
        [jd_emojiButton setBackgroundImage:[XYGIMFaceManager imageForEmotionPNGName:@"chat_bar_emoji_highlight"] forState:UIControlStateSelected];
        jd_emojiButton.tag = XYGIMShowEmojiFace;
        [jd_emojiButton addTarget:self action:@selector(changeFaceType:) forControlEvents:UIControlEventTouchUpInside];
        [jd_emojiButton sizeToFit];
        [_bottomView addSubview:self.emojiButton = jd_emojiButton];
        [jd_emojiButton setFrame:CGRectMake(recentButton.frame.size.width, _bottomView.frame.size.height/2-jd_emojiButton.frame.size.height/2, jd_emojiButton.frame.size.width, jd_emojiButton.frame.size.height)];
        
        UIButton *emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [emojiButton setImage:[XYGIMFaceManager imageForEmotionPNGName:@"icon_002_cover"] forState:UIControlStateNormal];
        [emojiButton setImage:[XYGIMFaceManager imageForEmotionPNGName:@"icon_002_cover"] forState:UIControlStateHighlighted];
        [emojiButton setImage:[XYGIMFaceManager imageForEmotionPNGName:@"icon_002_cover"] forState:UIControlStateSelected];
        emojiButton.tag = XYGIMShowEmojiFace;
        [emojiButton addTarget:self action:@selector(changeFaceType:) forControlEvents:UIControlEventTouchUpInside];
        emojiButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //[emojiButton sizeToFit];
        [_bottomView addSubview:emojiButton];
        
        float maxX = jd_emojiButton.frame.origin.x + jd_emojiButton.frame.size.width;
        [emojiButton setFrame:CGRectMake(maxX, _bottomView.frame.size.height/2-jd_emojiButton.frame.size.height/2, jd_emojiButton.frame.size.width, jd_emojiButton.frame.size.height)];
        
        
    }
    return _bottomView;
}

/**
 *  每一页显示的表情数量 = M每行数量*N行
 */
- (NSUInteger)itemsPerPage {
    return self.maxRows * self.columnPerRow;
}


@end
