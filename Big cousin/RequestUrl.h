
//
//  RequestUrl.h
//  Big cousin
//
//  Created by HMS,CK,LYB,SS on 16/7/14.
//  Copyright © 2016年 Twilight. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h

/*-------------- 表情库 ---------------*/

/** 轮播图URL */
#define VTCycleScrollView_Url(ID) [NSString stringWithFormat:@"http://api.jiefu.tv/app2/api/bq/article/detail.html?id=%@",ID]

/** 小标题 */
#define HomeTitle_Url @"http://cdn.ibiaoqing.com/ibiaoqing/admin/status/list.do"

#define ExpressionLibrary_Url(ID) [NSString stringWithFormat:@"http://123.57.155.230/ibiaoqing/admin/status/getByStatusId.do?pageNumber=1&statusId=%@&versionNumber=2.5.0",ID]

/** 最新 */
#define NewestExpression_Url @"http://123.57.155.230/ibiaoqing/admin/expre/listBy.do?pageNumber=1&status=Y&status1=B&versionNumber=2.5.0"

/** 最热 */
#define HottestExpression_Url @"http://123.57.155.230/ibiaoqing/admin/expre/listBy.do?pageNumber=1&status=Y&status1=B&count=yes&versionNumber=2.5.0"

/*-------------- 大制作 ---------------*/

/** 最新 */
#define staticDrawingNews_Url @"http://123.57.155.230/ibiaoqing/admin/expre/listBy.do?pageNumber=1&status=Y&status1=B&count=yes&versionNumber=2.5.0"

/*-------------- 大表姐 ---------------*/

/** GIFUrl */
#define BigCousinGIFAuthorsRequest_Url @"http://api.jiefu.tv/app2/api/article/list.html?mediaType=1&deviceCode=B8EDD4671B3F5BDABC4856102486409C&token=&pageNum=0&pageSize=20"
/** 视频Url */
#define BigCousinVideoAuthorsRequest_Url @"http://api.jiefu.tv/app2/api/article/list.html?mediaType=2&deviceCode=B8EDD4671B3F5BDABC4856102486409C&token=&pageNum=0&pageSize=20"
















#endif /* RequestUrl_h */
